import UIKit

protocol Coordinator: AnyObject {
    func start()
}

protocol CoordinatorsFabric {
    func createGeneralCoordinator() -> (Coordinator, Presentable)
}

final class CoordinatorsFabricImp: CoordinatorsFabric {
    
    func createGeneralCoordinator() -> (Coordinator, Presentable) {
        let controller = ControllersFabricImp().createWordSearchViewController()
        let generalCoordinator = GeneralCoordinatorImp(controller: controller, controllerFabric: ControllersFabricImp(), coordinatorFabric: CoordinatorsFabricImp())
        return (generalCoordinator,controller)
    }
}












