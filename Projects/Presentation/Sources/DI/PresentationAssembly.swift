import Foundation
import Swinject
import Core
import Domain

public final class PresentationAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        // Login
        container.register(LoginViewModel.self) { resolver in
            LoginViewModel()
        }
        container.register(LoginViewController.self) { resolver in
            LoginViewController(viewModel: resolver.resolve(LoginViewModel.self)!)
        }

        // SignUp - Name
        container.register(NameViewModel.self) { resolver in
            NameViewModel(signUpUseCase: resolver.resolve(SignUpUseCase.self)!)
        }
        container.register(NameViewController.self) { resolver in
            NameViewController(viewModel: resolver.resolve(NameViewModel.self)!)
        }

        // SignUp - Rank
        container.register(RankViewModel.self) { _ in
            RankViewModel()
        }
        container.register(RankViewController.self) { resolver in
            RankViewController(viewModel: resolver.resolve(RankViewModel.self)!)
        }
    }
}
