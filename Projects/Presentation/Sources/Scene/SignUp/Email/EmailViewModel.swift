import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain
import DesignSystem

public class EmailViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    public struct Input {
        let emailText: Observable<String>
        let clickNextButton: Observable<Void>
        let nextButton: PMButton
    }
    public struct Output {}
    public func transform(input: Input) -> Output {
        let emailText = input.emailText.share()
        emailText
            .map { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .subscribe(onNext: { isEnabled in
                input.nextButton.isEnabled = isEnabled
            })
            .disposed(by: disposeBag)
        input.clickNextButton
            .withLatestFrom(emailText)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.steps.accept(PMStep.selfIsRequired)
            })
            .disposed(by: disposeBag)

        return Output()
    }
}
