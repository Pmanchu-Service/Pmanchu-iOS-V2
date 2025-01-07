import Foundation
import Core
import Domain
import Swinject

public final class DataSourceAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(AuthDataSource.self) { resolver in
            AuthDataSourceImpl()
        }
    }
}
