import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class HomeViewModel: Stepper, BaseViewModel {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    public let bellButtonTapped = PublishRelay<Void>()
    public init() {
        bellButtonTapped
            .map { PMStep.notice }
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
    public struct Input {
        let bellTap: Observable<Void>
    }

    public struct Output {}

    public func transform(input: Input) -> Output {
        input.bellTap
            .bind(to: bellButtonTapped)
            .disposed(by: disposeBag)

        return Output()
    }
}
