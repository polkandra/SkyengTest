import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorsFabric
    private var window: UIWindow?
    private var launchInstructor = LaunchInstructor.configure()
    
    init(window: UIWindow?, coordinatorFactory: CoordinatorsFabric) {
        self.coordinatorFactory = coordinatorFactory
        self.window = window
    }
    
    override func start() {
        switch launchInstructor {
        case .main:
            runMainFlow()
        }
    }
    
    private func runMainFlow() {
        let (coordinator, controller) = coordinatorFactory.createGeneralCoordinator()
        let navController = UINavigationController(rootViewController: controller.toPresent() ?? UINavigationController())
        let presenter = WordsSearchPresenterImp(coordinator: coordinator as! GeneralCoordinator, controller: controller as! WordsSearchViewController, networkManager: NetworkManager(), wordsSearchMapper: WordSearchMapperImp())
        (controller as! WordsSearchViewController).presenter = presenter
        
        addDependency(coordinator)
        coordinator.start()
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

