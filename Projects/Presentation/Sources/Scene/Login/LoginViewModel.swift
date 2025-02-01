import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain
import Data

public class LoginViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()

    public struct Input {
        let clickGitHubButton: Observable<Void>
    }

    public struct Output {}

    public func transform(input: Input) -> Output {
        input.clickGitHubButton
            .flatMap { _ -> Observable<Step> in
                return Completable.create { completable in
                    LoginManager.shared.requestCode()
                    completable(.completed)
                    return Disposables.create()
                }
                .andThen(Observable.just(PMStep.start))
                .catch { _ in Observable.just(PMStep.start) }
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }

    public init() {}
}
