import Foundation
import Core
import Domain
import Swinject

public final class DataSourceAssembly: Assembly {
    public init() {}

    private let keychain = { (resolver: Resolver) in
        resolver.resolve(Keychain.self)!
    }

    public func assemble(container: Container) {
        container.register(Keychain.self) { _ in
            KeychainImpl()
        }.inObjectScope(.container)

        container.register(AuthDataSource.self) { resolver in
            AuthDataSourceImpl(keychain: self.keychain(resolver))
        }
        container.register(AuthDataSource.self) { resolver in
            AuthDataSourceImpl(keychain: self.keychain(resolver))
        }
    }
}
