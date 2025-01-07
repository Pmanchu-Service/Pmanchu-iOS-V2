import Foundation
import Moya
import Core
import Domain
import AppNetwork

public enum AuthAPI {
    case signUp(req: SignUpRequestParams)
    case refreshToken
}

extension AuthAPI: PMAPI {
    public typealias ErrorType = PMError

    public var urlType: PMURL {
        return .user
    }

    public var urlPath: String {
        switch self {
        case .signUp:
            return "/auth/update"
        case .refreshToken:
            return "/refresh"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .signUp:
            return .post
        case .refreshToken:
            return .put
        }
    }

    public var task: Moya.Task {
        switch self {
        case let .signUp(req):
            return .requestJSONEncodable(req)
        default:
            return .requestPlain
        }
    }

    public var pmHeader: TokenType {
        switch self {
        case .refreshToken:
            return .refreshToken
        default:
            return .tokenIsEmpty
        }
    }

    public var errorMap: [Int: PMError]? {
        return [
            500: .serverError,
            503: .serverError
        ]
    }
}
