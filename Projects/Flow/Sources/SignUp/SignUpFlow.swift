import UIKit
import RxFlow
import Swinject
import Core
import Presentation

public class SignUpFlow: Flow {
    public var root: Presentable {
        return self.rootViewController
    }
    private let container: Container
    private let rootViewController: UINavigationController
    public init(container: Container) {
        self.container = container
        self.rootViewController = UINavigationController()
    }
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? PMStep else { return .none }

        switch step {
            case .nameIsRequired:
                return navigateToName()
            case .rankIsRequired:
                return navigateToRank()
            default:
                return .none
        }
    }
    private func navigateToName() -> FlowContributors {
        let viewController = container.resolve(NameViewController.self)!
        rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    private func navigateToRank() -> FlowContributors {
        let viewController = container.resolve(RankViewController.self)!
        rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
}
