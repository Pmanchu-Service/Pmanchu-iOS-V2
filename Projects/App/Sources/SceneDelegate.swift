import UIKit
import Presentation
import Swinject
import RxFlow
import Core
import Flow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var coordinator: FlowCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let container = Container()
        let presentationAssembly = PresentationAssembly()
        presentationAssembly.assemble(container: container)
        let flow = SignUpFlow(container: container)
        coordinator = FlowCoordinator()
        coordinator?.coordinate(flow: flow, with: OneStepper(withSingleStep: PMStep.signUpIsRequired))
        window?.rootViewController = flow.root as? UIViewController
        window?.makeKeyAndVisible()
    }
}
func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

