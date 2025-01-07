import Foundation
import Domain
import Swinject

public final class UseCaseAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        // Auth
        container.register(SignUpUseCase.self) { resolver in
            SignUpUseCase(repository: resolver.resolve(AuthRepository.self)!)
        }
        
        container.register(RefreshTokenUseCase.self) { resolver in
            RefreshTokenUseCase(repository: resolver.resolve(AuthRepository.self)!)
        }
    }
}
