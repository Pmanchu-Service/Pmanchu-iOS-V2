import UIKit
import RxFlow
import Swinject
import Core
import Presentation

public class SignUpFlow: Flow {
   public let container: Container
   private var rootViewController = UINavigationController()

   public var root: Presentable {
       return rootViewController
   }

   public init(container: Container) {
       self.container = container
   }

    public func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? PMStep else { return .none }

        switch step {
        case .signUpIsRequired:
            return navigateToSignUp()
        case .rankIsRequired:
            if !rootViewController.viewControllers.contains(where: { $0 is RankViewController }) {
                return navigateToRank()
            }
            return .none
        default:
            return .none
        }
    }

   private func navigateToSignUp() -> FlowContributors {
       let signUpVC = container.resolve(NameViewController.self)!
       rootViewController.pushViewController(signUpVC, animated: true)
       return .one(flowContributor: .contribute(
           withNextPresentable: signUpVC,
           withNextStepper: signUpVC.viewModel
       ))
   }

   private func navigateToRank() -> FlowContributors {
       let rankVC = container.resolve(RankViewController.self)!
       rootViewController.pushViewController(rankVC, animated: true)
       return .one(flowContributor: .contribute(
           withNextPresentable: rankVC,
           withNextStepper: rankVC.viewModel
       ))
   }
}
