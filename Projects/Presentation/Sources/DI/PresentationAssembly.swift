import Foundation
import Swinject
import Core
import Domain

public final class PresentationAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {

        container.register(LoginViewModel.self) { resolver in
            LoginViewModel()
        }
        container.register(LoginViewController.self) { resolver in
            LoginViewController(viewModel: resolver.resolve(LoginViewModel.self)!)
        }

        container.register(RankViewModel.self) { _ in
            RankViewModel()
        }
        container.register(RankViewController.self) { resolver in
            RankViewController(viewModel: resolver.resolve(RankViewModel.self)!)
        }
    }
}
