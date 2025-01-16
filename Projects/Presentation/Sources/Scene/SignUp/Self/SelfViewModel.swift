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
        let isButtonEnabled: Driver<Bool>
    }

    public func transform(input: Input) -> Output {
        let selfText = input.selfText.share()
        let isButtonEnabled = selfText
            .map { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .asDriver(onErrorJustReturn: false)
        input.clickNextButton
            .withLatestFrom(selfText)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.steps.accept(PMStep.skillIsRequired)
            })
            .disposed(by: disposeBag)
        return Output(
            isButtonEnabled: isButtonEnabled
        )
    }
}
