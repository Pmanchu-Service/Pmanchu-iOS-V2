import Foundation

public enum TokenError: Error {
    case expired
}

extension TokenError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .expired:
            return NSLocalizedString("토큰이 만료되었습니다.", comment: "Expired Token")
        }
    }
}
