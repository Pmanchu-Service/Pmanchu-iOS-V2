import UIKit
import RxFlow
import Swinject
import Core
import Presentation

public class NoticeFlow: Flow {
    public let container: Container
    private var rootViewController = BaseNavigationController()

    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: any RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? PMStep else { return .none }
        
        switch step {
        case .notice:
            return navigateToNotice()
        default:
            return .none
        }
    }
    
    private func navigateToNotice() -> FlowContributors {
        let noticeViewController = container.resolve(NoticeViewController.self)!
        self.rootViewController.pushViewController(noticeViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: noticeViewController,
            withNextStepper: noticeViewController.viewModel
        ))
    }
}
