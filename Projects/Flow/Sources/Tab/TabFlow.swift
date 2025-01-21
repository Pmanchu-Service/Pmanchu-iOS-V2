import UIKit
import RxFlow
import RxCocoa
import RxSwift
import Swinject
import Core
import DesignSystem
import Presentation

public class TabsFlow: Flow {
    public let container: Container
    private let rootViewController =  BaseTabBarController()
    public var root: Presentable {
        return self.rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    private lazy var homeFlow = HomeFlow(container: container)
    private lazy var userSearchFlow = UserSearchFlow(container: container)
    private lazy var heartFlow = HeartFlow(container: container)
    private lazy var profileFlow = ProfileFlow(container: container)

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? PMStep else { return .none }

        switch step {
        case .tabIsRequired:
            return setupTabBar()
        case .appIsRequired:
            return dismissToOnbording()
        case .popIsRequired:
            return .end(forwardToParentFlowWithStep: PMStep.tabIsRequired)
        default:
            return .none
        }
    }

    private func setupTabBar() -> FlowContributors {
        Flows.use(
            homeFlow,
            userSearchFlow,
            heartFlow,
            profileFlow,
            when: .created
        ) { home, userSearch, heart, profile in
            home.tabBarItem = PMTabBarTypeItem(.home)
            userSearch.tabBarItem = PMTabBarTypeItem(.userSearch)
            heart.tabBarItem = PMTabBarTypeItem(.heart)
            profile.tabBarItem = PMTabBarTypeItem(.profile)

            self.rootViewController.setViewControllers([
                home,
                userSearch,
                heart,
                profile
            ], animated: false)
        }
        return .multiple(flowContributors: [
            .contribute(
                withNextPresentable: homeFlow,
                withNextStepper: OneStepper(withSingleStep: PMStep.homeIsRequired)
            ),
            .contribute(
                withNextPresentable: userSearchFlow,
                withNextStepper: OneStepper(withSingleStep: PMStep.userIsRequired)
            ),
            .contribute(
                withNextPresentable: heartFlow,
                withNextStepper: OneStepper(withSingleStep: PMStep.heartIsRequired)
            ),
            .contribute(
                withNextPresentable: profileFlow,
                withNextStepper: OneStepper(withSingleStep: PMStep.profileIsRequired)
            )
        ])
    }

    private func dismissToOnbording() -> FlowContributors {
        UIView.transition(
            with: self.rootViewController.view.window!,
            duration: 0.5,
            options: .transitionCrossDissolve) {
                self.rootViewController.dismiss(animated: false)
            }

        return .end(forwardToParentFlowWithStep: PMStep.onboardingIsRequired)
    }

}
