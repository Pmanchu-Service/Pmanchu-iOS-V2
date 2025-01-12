import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class RankViewModel: BaseViewModel, Stepper {
    public struct Input {
        let rankText: Observable<String>
        let nextButtonTap: Observable<Void>
    }

    public struct Output {
        let isNextButtonEnabled: Driver<Bool>
        let nextStep: Driver<PMStep>
    }

    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    private let savedRankText = BehaviorRelay<String?>(value: nil)
    public func transform(input: Input) -> Output {
        let isNextButtonEnabled = input.rankText
            .map { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .asDriver(onErrorJustReturn: false)

        input.nextButtonTap
            .withLatestFrom(input.rankText)
            .subscribe(onNext: { [weak self] rank in
                self?.savedRankText.accept(rank)
            })
            .disposed(by: disposeBag)

        let nextStep = input.nextButtonTap
            .map { PMStep.rankIsRequired }
            .asDriver(onErrorJustReturn: PMStep.rankIsRequired)

        return Output(
            isNextButtonEnabled: isNextButtonEnabled,
            nextStep: nextStep
        )
    }
}
