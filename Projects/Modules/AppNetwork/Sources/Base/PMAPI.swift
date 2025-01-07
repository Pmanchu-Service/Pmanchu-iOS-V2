import Foundation
import Moya
import Core

public protocol PMAPI: TargetType {
    associatedtype ErrorType: Error
    var urlType: PMURL { get }
    var urlPath: String { get }
    var pmHeader: TokenType { get }
    var errorMap: [Int: ErrorType]? { get }
}

public extension PMAPI {
    var baseURL: URL {
        URLUtil.baseURL
    }
    
    var path: String {
        urlType.asURLString + urlPath
    }
    
    var headers: [String: String]? {
        switch pmHeader {
        case .accessToken:
            return TokenStorage.shared.toHeader(.accessToken)
        case .refreshToken:
            return TokenStorage.shared.toHeader(.refreshToken)
        case .tokenIsEmpty:
            return ["Content-Type": "application/json"]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

public enum PMURL: String {
    case auth
    case user
    case rank
    
    var asURLString: String {
        "/\(self.rawValue)"
    }
}

public enum TokenType: String {
    case accessToken
    case refreshToken
    case tokenIsEmpty
    
    var toHeader: [String: String] {
        switch self {
        case .accessToken:
            return TokenStorage.shared.toHeader(.accessToken)
        case .refreshToken:
            return TokenStorage.shared.toHeader(.refreshToken)
        case .tokenIsEmpty:
            return ["Content-Type": "application/json"]
        }
    }
}
