import Foundation

import RxSwift
import RxCocoa
import RxFlow

import Core
import Domain

public class LoginViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()

    public struct Input {
        let clickGithuhButton: Observable<Void>
    }

    public struct Output {}

    public func transform(input: Input) -> Output {
        input.clickGithuhButton
            .map { PMStep.signUpIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }

    public init() {}
}
