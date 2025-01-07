import Foundation

import RxSwift

public protocol AuthRepository {
    func signUp(req: SignUpRequestParams) -> Completable
    func refreshToken() -> Completable
}
