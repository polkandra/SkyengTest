
import UIKit

protocol AppRouter {
    func remove(_ childController: Presentable)
    func present(_ controller: Presentable?)
    func push(_ controller: Presentable?)
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?)
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?)
    func popController()
    func popController(transition: UIViewControllerAnimatedTransitioning?)
    func popController(transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    func popToController(_ controller: Presentable?, animated: Bool)
    func dismissController()
    func dismissController(animated: Bool, completion: (() -> Void)?)
    func setRootController(_ controller: Presentable?)
    func popToRootController(animated: Bool)
    var rootController: UINavigationController? { get }
}

final class AppRouterImp: NSObject, AppRouter {
    
    weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    private var transition: UIViewControllerAnimatedTransitioning?
    
    init(rootController: UINavigationController?) {
        self.rootController = rootController
        completions = [:]
        super.init()
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func remove(_ childController: Presentable) {
        childController.toPresent()?.removeFromParent()
        childController.toPresent()?.view.removeFromSuperview()
    }
   
    func present(_ controller: Presentable?)  {
        present(controller, transition: nil)
    }
    
    func present(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?) {
        self.present(controller, transition: transition, animated: true)
    }
    
    func present(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)  {
        guard let controller = controller?.toPresent() else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func dismissController() {
        dismissController(animated: true, completion: nil)
    }
    
    func dismissController(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ controller: Presentable?)  {
        push(controller, transition: nil)
    }
    
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?) {
        self.push(controller, transition: transition, animated: true)
    }
    
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)  {
        push(controller, transition: transition, animated: animated, completion: nil)
    }
    
    func push(_ controller: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?) {
        self.transition = transition
        guard let controller = controller?.toPresent(), (controller is UINavigationController == false) else { return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popController() {
        popController(transition: nil)
    }
    
    func popController(transition: UIViewControllerAnimatedTransitioning?) {
        popController(transition: transition, animated: true)
    }
    
    func popController(transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        self.transition = transition
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func popToController(_ controller: Presentable?, animated: Bool) {
        if let controllers = self.rootController?.viewControllers , let module = controller {
            for controller in controllers {
                if controller == module as! UIViewController {
                    self.rootController?.popToViewController(controller, animated: animated)
                    break
                }
            }
        }
    }
    
    func setRootController(_ controller: Presentable?) {
        setRootController(controller, hideBar: false)
    }
    
    func setRootController(_ controller: Presentable?, hideBar: Bool) {
        guard let controller = controller?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootController(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

extension AppRouterImp: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
}
