import Foundation
import Swinject
import Core
import Domain

public final class PresentationAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {

        container.register(NameViewModel.self) { _ in
            NameViewModel()
        }

        container.register(RankViewModel.self) { _ in
            RankViewModel()
        }

        container.register(NameViewController.self) { resolver in
            NameViewController(viewModel: resolver.resolve(NameViewModel.self)!)
        }
        
        container.register(RankViewController.self) { resolver in
            RankViewController(viewModel: resolver.resolve(RankViewModel.self)!)
        }
    }
}
