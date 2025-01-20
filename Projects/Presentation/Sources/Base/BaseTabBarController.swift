import UIKit

import Core
import DesignSystem

public class BaseTabBarController: UITabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    private func setupTabBar() {
        self.tabBar.tintColor = .gray5
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .main2
        self.delegate = self

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .systemPink
        appearance.backgroundColor = .green
        self.tabBar.scrollEdgeAppearance = appearance
    }

}

extension BaseTabBarController: UITabBarControllerDelegate {
    public func tabBarController(
        _ tabBarController: UITabBarController,
        animationControllerForTransitionFrom fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransitionAnimator()
    }
}

class FadeTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let transitionDuration: Double = 0.3

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let fromVC = transitionContext.viewController(forKey: .from),
              let fromView = fromVC.view,
              let toVC = transitionContext.viewController(forKey: .to),
              let toView = toVC.view
        else {
            transitionContext.completeTransition(false)
            return
        }

        let containerView = transitionContext.containerView
        toView.alpha = 0
        containerView.addSubview(toView)

        UIView.animate(withDuration: self.transitionDuration, animations: {
            fromView.alpha = 0
            toView.alpha = 1
        }) { success in
            fromView.alpha = 1
            transitionContext.completeTransition(success)
        }
    }
}
