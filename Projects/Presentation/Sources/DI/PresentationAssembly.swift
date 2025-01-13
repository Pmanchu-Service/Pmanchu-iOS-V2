import Foundation
import Swinject
import Core
import Data
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
        container.register(NameViewController.self) { resolver in
            NameViewController(viewModel: resolver.resolve(NameViewModel.self)!)
        }
        container.register(NameViewModel.self) { resolver in
            NameViewModel(signUpUseCase: resolver.resolve(SignUpUseCase.self)!)
        }

        // SignUp - Rank
        container.register(RankViewModel.self) { _ in
            RankViewModel()
        }
        container.register(RankViewController.self) { resolver in
            RankViewController(viewModel: resolver.resolve(RankViewModel.self)!)
        }

        // SignUp - Email
        container.register(EmailViewModel.self) { _ in
            EmailViewModel()
        }
        container.register(EmailViewController.self) { resolver in
            EmailViewController(viewModel: resolver.resolve(EmailViewModel.self)!)
        }

    }
}
