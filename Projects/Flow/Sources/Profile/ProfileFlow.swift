import UIKit
import RxFlow
import Swinject
import Core
import Presentation

public class ProfileFlow: Flow {
    public let container: Container
    private let rootViewController = BaseNavigationController()
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? PMStep else { return .none }

        switch step {
        case .profileIsRequired:
            return navigateToProfile()
        default:
            return .none
        }
    }

    private func navigateToProfile() -> FlowContributors {
        let vc = container.resolve(ProfileViewController.self)!

        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: vc,
            withNextStepper: vc.viewModel
        ))
    }

}
