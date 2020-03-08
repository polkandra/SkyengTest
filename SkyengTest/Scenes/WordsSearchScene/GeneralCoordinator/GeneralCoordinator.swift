
import Foundation
import UIKit


protocol GeneralCoordinator: AnyObject {
    func tappedOnModel(model: WordsSearchModel)
}

class GeneralCoordinatorImp: BaseCoordinator {
    var router: AppRouter?
    var controllersFabric: ControllersFabric
    private let coordinatorsFabric: CoordinatorsFabric
    var controller: UIViewController
    
    init(controller: UIViewController, controllerFabric: ControllersFabric, coordinatorFabric: CoordinatorsFabric) {
        self.controllersFabric = controllerFabric
        self.coordinatorsFabric = coordinatorFabric
        self.controller = controller
    }
    
    override func start() {
        let wordsSearchController = controllersFabric.createWordSearchViewController()
        let presenter = WordsSearchPresenterImp(coordinator: self, controller: wordsSearchController, networkManager: NetworkManager(), wordsSearchMapper: WordSearchMapperImp())
        wordsSearchController.presenter = presenter
        let navController = UINavigationController(rootViewController: wordsSearchController)
        router = AppRouterImp(rootController: navController)
    }
}

extension GeneralCoordinatorImp: GeneralCoordinator {
    func tappedOnModel(model: WordsSearchModel) {
        let detailsController = controllersFabric.createWordDetailsViewController()
        let presenter = WordDetailsPresenterImp(model: model, controller: detailsController, networkManager: NetworkManager(), wordsSearchMapper: WordDetailsMapperImp())
        detailsController.presenter = presenter
        controller.navigationController?.pushViewController(detailsController, animated: true)
    }
}
