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
        container.register(HomeViewModel.self) { _ in
            HomeViewModel()
        }
        container.register(HomeViewController.self) { resolver in
            HomeViewController(viewModel: resolver.resolve(HomeViewModel.self)!)
        }

        // MARK: UserSearch
        container.register(UserSearchViewController.self) { resolver in
            UserSearchViewController(viewModel: resolver.resolve(UserSearchViewModel.self)!)
        }

        // MARK: Profile
        container.register(ProfileViewController.self) { resolver in
            ProfileViewController(viewModel: resolver.resolve(ProfileViewModel.self)!)
        }

        // MARK: Heart
        container.register(HeartViewController.self) { resolver in
            HeartViewController(viewModel: resolver.resolve(HeartViewModel.self)!)
        }
        container.register(UserSearchViewModel.self) { _ in
            UserSearchViewModel()
        }
        container.register(ProfileViewModel.self) { _ in
            ProfileViewModel()
        }
        container.register(HeartViewModel.self) { _ in
            HeartViewModel()
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

        // SignUp - Self
        container.register(SelfViewModel.self) { _ in
            SelfViewModel()
        }
        container.register(SelfViewController.self) { resolver in
            SelfViewController(viewModel: resolver.resolve(SelfViewModel.self)!)
        }

        // SignUp - Skill
        container.register(SkillViewModel.self) { _ in
            SkillViewModel()
        }
        container.register(SkillViewController.self) { resolver in
            SkillViewController(viewModel: resolver.resolve(SkillViewModel.self)!)
        }

        // SignUp - major
        container.register(MajorViewModel.self) { _ in
            MajorViewModel()
        }
        container.register(MajorViewController.self) { resolver in
            MajorViewController(viewModel: resolver.resolve(MajorViewModel.self)!)
        }
    }
}
