import UIKit

import RxFlow
import Swinject

import Core
import Presentation

public class LoginFlow: Flow {
    public let container: Container
    private var rootViewController = UINavigationController()

    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: any RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? PMStep else { return .none }

        switch step {
        case .loginIsRequired:
            return navigateToLogin()
        case .signUpIsRequired:
            return navigateToSignup()
        default:
            return .none
        }
    }

    private func navigateToLogin() -> FlowContributors {
        let loginVC = container.resolve(LoginViewController.self)!
        self.rootViewController.pushViewController(loginVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: loginVC,
            withNextStepper: loginVC.viewModel
        ))
    }
    private func navigateToSignup() -> FlowContributors {
        let signupVC = container.resolve(NameViewController.self)!
        self.rootViewController.pushViewController(signupVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: signupVC,
            withNextStepper: signupVC.viewModel
        ))
    }
}
