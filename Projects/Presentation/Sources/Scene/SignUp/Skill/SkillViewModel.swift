import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain
import DesignSystem

public class SkillViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    public struct Input {
        let skillText: Observable<String>
        let clickNextButton: Observable<Void>
        let nextButton: PMButton
    }
    public struct Output {
        let isButtonEnabled: Driver<Bool>
    }
    public func transform(input: Input) -> Output {
        let skillText = input.skillText.share()
        let isButtonEnabled = skillText
            .map { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .asDriver(onErrorJustReturn: false)
        input.clickNextButton
            .withLatestFrom(skillText)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.steps.accept(PMStep.majorIsRequired)
            })
            .disposed(by: disposeBag)
        return Output(
            isButtonEnabled: isButtonEnabled
        )
    }
}
