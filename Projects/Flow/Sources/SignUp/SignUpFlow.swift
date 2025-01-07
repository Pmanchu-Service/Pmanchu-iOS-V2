import UIKit
import RxFlow
import Swinject
import Core
import Presentation

public final class SignUpFlow: Flow {
    private let container: Container
    private let rootViewController = UINavigationController()
    
    public var root: Presentable {
        return rootViewController
    }
    
    public init(container: Container) {
        self.container = container
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? PMStep else { return .none }
        
        switch step {
        case .signUpIsRequired:
            return navigateToName()
        case .rankIsRequired:
            return navigateToRank()
        default:
            return .none
        }
    }
    
    private func navigateToName() -> FlowContributors {
        let vc = container.resolve(NameViewController.self)!
        rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: vc,
            withNextStepper: vc.viewModel
        ))
    }
    
    private func navigateToRank() -> FlowContributors {
        let vc = container.resolve(RankViewController.self)!
        rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: vc,
            withNextStepper: vc.viewModel
        ))
    }
}
