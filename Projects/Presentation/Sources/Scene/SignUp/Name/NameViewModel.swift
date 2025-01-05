import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class NameViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    public struct Input {
        let nameText: Observable<String>
        let clickNextButton: Observable<Void>
    }

    public struct Output {
        let isNextButtonEnabled: Driver<Bool>
        let nextStep: Driver<PMStep>
    }

    public func transform(input: Input) -> Output {
        let isNextButtonEnabled = input.nameText
            .map { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .asDriver(onErrorJustReturn: false)

        input.clickNextButton
            .map { PMStep.rankIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        let nextStep = input.clickNextButton
            .map { PMStep.rankIsRequired }
            .asDriver(onErrorJustReturn: PMStep.rankIsRequired)

        return Output(isNextButtonEnabled: isNextButtonEnabled, nextStep: nextStep)
    }

    public init() {}
}
