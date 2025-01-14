import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain
import DesignSystem

public class SelfViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    public struct Input {
        let selfText: Observable<String>
        let clickNextButton: Observable<Void>
        let nextButton: PMButton
    }
    public struct Output {
        let isNextButtonEnabled: Driver<Bool>
        let nextStep: Driver<Step>
    }

    public func transform(input: Input) -> Output {
        let selfText = input.selfText.share()
        
        let isNextButtonEnabled = selfText
            .map { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .asDriver(onErrorJustReturn: false)
        
        let nextStep = input.clickNextButton
            .withLatestFrom(selfText)
            .map { _ in PMStep.selfIsRequired as Step }
            .asDriver(onErrorJustReturn: PMStep.selfIsRequired as Step)

        
        return Output(
            isNextButtonEnabled: isNextButtonEnabled,
            nextStep: nextStep
        )
    }
}
