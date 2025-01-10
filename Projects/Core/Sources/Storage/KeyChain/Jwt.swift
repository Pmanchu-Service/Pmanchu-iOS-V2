import Foundation

public enum KeychainType: String {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
    case tokenIsEmpty

    case name
    case major
    case rank
    case introduction
    case shortIntroduction
    case contact
    case links
    case stacks
}

public protocol Keychain {
    func save(type: KeychainType, value: String)
    func load(type: KeychainType) -> String
    func delete(type: KeychainType)
}
