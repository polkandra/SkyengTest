
import UIKit

protocol ControllersFabric {
    func createWordSearchViewController() -> WordsSearchViewController
    func createWordDetailsViewController() -> WordDetailsViewController
}

final class ControllersFabricImp: ControllersFabric {
   
    func createWordSearchViewController() -> WordsSearchViewController {
        return WordsSearchViewController(nibName: String(describing: WordsSearchViewController.self), bundle: nil)
    }
    
    func createWordDetailsViewController() -> WordDetailsViewController {
        return WordDetailsViewController(nibName: String(describing: WordDetailsViewController.self), bundle: nil)
    }
}
