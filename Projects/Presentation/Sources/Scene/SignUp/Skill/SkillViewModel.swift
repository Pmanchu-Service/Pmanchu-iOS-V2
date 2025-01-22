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
    public let deleteSkillSubject = PublishRelay<String>()
    private let skillListRelay = BehaviorRelay<[String]>(value: [])
    private var skillList: [String] = [] {
        didSet {
            skillListRelay.accept(skillList)
        }
    }

    public struct Input {
        let skillText: Observable<String>
        let clickNextButton: Observable<Void>
        let addButtonTap: Observable<Void>
        let deleteSkill: Observable<String>
        let nextButton: PMButton
    }

    public struct Output {
        let isButtonEnabled: Driver<Bool>
        let skills: Driver<[String]>
    }

    public func transform(input: Input) -> Output {
        let skillText = input.skillText.share()

        input.addButtonTap
            .withLatestFrom(skillText)
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                if !self.skillList.contains(trimmedText) {
                    self.skillList.append(trimmedText)
                }
            })
            .disposed(by: disposeBag)

        input.deleteSkill
            .subscribe(onNext: { [weak self] skill in
                guard let self = self else { return }
                self.skillList.removeAll { $0 == skill }
            })
            .disposed(by: disposeBag)

        let isButtonEnabled = skillListRelay
            .map { $0.count >= 1 }
            .asDriver(onErrorJustReturn: false)

        let skills = skillListRelay
            .asDriver(onErrorJustReturn: [])

        input.clickNextButton
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.steps.accept(PMStep.majorIsRequired)
            })
            .disposed(by: disposeBag)

        return Output(
            isButtonEnabled: isButtonEnabled,
            skills: skills
        )
    }
}
