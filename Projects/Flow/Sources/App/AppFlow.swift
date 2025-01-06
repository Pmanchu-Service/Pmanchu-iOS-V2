import UIKit
import RxFlow
import Swinject
import Core

public class AppFlow: Flow {
    private var window: UIWindow
    private let container: Container

    public var root: RxFlow.Presentable {
        return window
    }

    public init(window: UIWindow, container: Container) {
        self.window = window
        self.container = container
    }

    public func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? PMStep else {
            return .none
        }

        switch step {
        case .signUpIsRequired:
            return navigationToSignUp()
        default:
            return .none
        }
    }

    private func navigationToSignUp() -> FlowContributors {
        let signUpFlow = SignUpFlow(container: self.container)

        Flows.use(signUpFlow, when: .created) { [weak self] root in
            self?.window.rootViewController = root
        }

        return .one(
            flowContributor: .contribute(
                withNextPresentable: signUpFlow,
                withNextStepper: OneStepper(
                    withSingleStep: PMStep.signUpIsRequired
                )
            )
        )
    }
}
