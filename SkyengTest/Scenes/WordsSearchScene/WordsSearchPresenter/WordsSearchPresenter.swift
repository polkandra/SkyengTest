
import Foundation

protocol WordSearchPresenter: class {
    var wordsModels: [WordsSearchModel] { get }
    func fetchWords(by name: String)
    func didTapOnModel(model: WordsSearchModel)
}

class WordsSearchPresenterImp {
    private let coordinator: GeneralCoordinator
    private weak var controller: WordsSearchViewControllerProtocol?
    private let networkManager: NetworkManager
    private let wordsSearchMapper: WordSearchMapper
    private var privateWordsModels = [WordsSearchModel]()
    
    init(coordinator: GeneralCoordinator,
         controller: WordsSearchViewControllerProtocol,
         networkManager: NetworkManager,
         wordsSearchMapper: WordSearchMapper) {
        
        self.coordinator = coordinator
        self.controller = controller
        self.networkManager = networkManager
        self.wordsSearchMapper = wordsSearchMapper
    }
}

//MARK: - WordSearchPresenter
extension WordsSearchPresenterImp: WordSearchPresenter {
    //MARK: - Words fetching
    func fetchWords(by name: String) {
        controller?.startLoading()
        
        networkManager.getWords(name: name) { [weak self] (wordsArray, error) in
            guard let unwrappedSelf = self,
                let wordsArray = wordsArray else { return }
            unwrappedSelf.privateWordsModels = unwrappedSelf.wordsSearchMapper.mapWordsDTOInViewModels(words: wordsArray)
            unwrappedSelf.controller?.update()
            unwrappedSelf.controller?.setTable()
            unwrappedSelf.controller?.finishLoading()
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func didTapOnModel(model: WordsSearchModel) {
        coordinator.tappedOnModel(model: model)
    }
    
    var wordsModels: [WordsSearchModel] {
        get {
            return privateWordsModels
        }
    }
}
