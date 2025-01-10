import Foundation
import RxSwift
import Domain
import Core
import Moya

public final class AuthRepositoryImpl: AuthRepository {
    private let remoteDataSource: AuthDataSource
    private var disposeBag = DisposeBag()
    private let keyChain = KeychainImpl()

    init(remoteDataSource: AuthDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    public func signUp(req: SignUpRequestParams) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else { return Disposables.create {} }

            self.remoteDataSource.signUp(req: req)
                .subscribe(onSuccess: { tokenData in
                    self.keyChain.save(type: .accessToken, value: tokenData.accessToken)
                    self.keyChain.save(type: .refreshToken, value: tokenData.refreshToken)
                    completable(.completed)
                }, onFailure: {
                    completable(.error($0))
                })
                .disposed(by: self.disposeBag)
            return Disposables.create {}
        }
    }

    public func refreshToken() -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else { return Disposables.create {} }

            self.remoteDataSource.refreshToken()
                .subscribe(onSuccess: { tokenData in
                    self.keyChain.save(type: .accessToken, value: tokenData.accessToken)
                    self.keyChain.save(type: .refreshToken, value: tokenData.refreshToken)
                    completable(.completed)
                }, onFailure: {
                    completable(.error($0))
                })
                .disposed(by: self.disposeBag)

            return Disposables.create {}
        }
    }
}
