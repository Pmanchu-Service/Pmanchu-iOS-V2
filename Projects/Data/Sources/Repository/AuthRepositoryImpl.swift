import Foundation
import RxSwift
import Domain
import Moya

public final class AuthRepositoryImpl: AuthRepository {
    private let provider: MoyaProvider<AuthAPI>

    public init(provider: MoyaProvider<AuthAPI> = MoyaProvider<AuthAPI>()) {
        self.provider = provider
    }

    public func signUp(req: SignUpRequestParams) -> Completable {
        return provider.rx.request(.signUp(req: req))
            .asCompletable()
    }

    public func refreshToken() -> Completable {
        return provider.rx.request(.refreshToken)
            .asCompletable()
    }
}
