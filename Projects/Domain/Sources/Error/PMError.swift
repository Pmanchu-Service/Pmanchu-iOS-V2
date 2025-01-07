import Foundation

public enum PMError: Error {
    case error(message: String = "에러가 발생했습니다.", errorBody: [String: Any] = [:])
    case noInternet
    case serverError
}

extension PMError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error(let message, _):
            return message
        case .noInternet:
            return NSLocalizedString("인터넷 연결이 원활하지 않습니다.", comment: "No Internet Connection")
        case .serverError:
            return NSLocalizedString("서버 에러가 발생했습니다.", comment: "Server Error")
        }
    }
}
