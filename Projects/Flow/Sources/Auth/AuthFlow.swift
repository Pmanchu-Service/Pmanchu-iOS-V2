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
        case .nameIsRequired:
            return navigateToName()
        case .rankIsRequired:
            return navigateToRank()
        case .start:
            return navigateToSignup()
        case .emailIsRequired:
            return navigateToEmail()
        case .selfIsRequired:
            return navigateToSelf()
        case .skillIsRequired:
            return navigateToSkill()
        case .majorIsRequired:
            return navigateToMajor()
        default:
            return .none
        }
    }
    private func navigateToMajor() -> FlowContributors {
        let majorViewController = container.resolve(MajorViewController.self)!
        self.rootViewController.pushViewController(majorViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: majorViewController,
            withNextStepper: majorViewController.viewModel
        ))
    }
    private func navigateToSkill() -> FlowContributors {
        let skillViewController = container.resolve(SkillViewController.self)!
        self.rootViewController.pushViewController(skillViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: skillViewController,
            withNextStepper: skillViewController.viewModel
        ))
    }
    private func navigateToSelf() -> FlowContributors {
        let selfViewController = container.resolve(SelfViewController.self)!
        self.rootViewController.pushViewController(selfViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: selfViewController,
            withNextStepper: selfViewController.viewModel
        ))
    }
    private func navigateToEmail() -> FlowContributors {
        let emailViewController = container.resolve(EmailViewController.self)!
        self.rootViewController.pushViewController(emailViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: emailViewController,
            withNextStepper: emailViewController.viewModel
        ))
    }
    private func navigateToRank() -> FlowContributors {
        let rankVC = container.resolve(RankViewController.self)!
        self.rootViewController.pushViewController(rankVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: rankVC,
            withNextStepper: rankVC.viewModel
        ))
    }

    private func navigateToLogin() -> FlowContributors {
        let loginVC = container.resolve(LoginViewController.self)!
        self.rootViewController.pushViewController(loginVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: loginVC,
            withNextStepper: loginVC.viewModel
        ))
    }

    private func navigateToName() -> FlowContributors {
        let nameVC = container.resolve(NameViewController.self)!
        self.rootViewController.pushViewController(nameVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: nameVC,
            withNextStepper: nameVC.viewModel
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
