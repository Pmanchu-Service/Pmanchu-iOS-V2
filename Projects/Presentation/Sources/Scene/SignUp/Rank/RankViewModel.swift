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
    
    public func transform(input: Input) -> Output {
        let isNextButtonEnabled = input.rankText
            .map { !$0.isEmpty }
            .asDriver(onErrorJustReturn: false)
        
        let nextStep = input.nextButtonTap
            .map { PMStep.rankIsRequired }
            .asDriver(onErrorJustReturn: PMStep.rankIsRequired)
        
        return Output(
            isNextButtonEnabled: isNextButtonEnabled,
            nextStep: nextStep
        )
    }
}
