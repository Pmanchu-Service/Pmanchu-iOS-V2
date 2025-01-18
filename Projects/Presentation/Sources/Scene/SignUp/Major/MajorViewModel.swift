import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class MajorViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()

    public struct Input {
        let nextButtonTap: Observable<Void>
    }
    public struct Output {
        let nextStep: Driver<PMStep>
    }
    public func transform(input: Input) -> Output {
        let nextStep = input.nextButtonTap
            .map { PMStep.toMainIsRequired }
            .asDriver(onErrorJustReturn: PMStep.toMainIsRequired)
        input.nextButtonTap
            .map { PMStep.toMainIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output(
            nextStep: nextStep
        )
    }
}
