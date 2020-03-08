
import Foundation

protocol WordDetailsPresenter: class {
    var wordModel: WordDetailsModel { get }
    func fetchWordDetails()
}

class WordDetailsPresenterImp {
    private weak var controller: WordDetailsViewControllerProtocol?
    private let networkManager: NetworkManager
    private let wordDetailsMapper: WordDetailsMapper
    private let model: WordsSearchModel
    private var privateWordDetailsModel: WordDetailsModel!
    
    init(model: WordsSearchModel, controller: WordDetailsViewControllerProtocol,
         networkManager: NetworkManager,
         wordsSearchMapper: WordDetailsMapper) {
        
        self.model = model
        self.controller = controller
        self.networkManager = networkManager
        self.wordDetailsMapper = wordsSearchMapper
    }
}

//MARK: - WordDetailsPresenter
extension WordDetailsPresenterImp: WordDetailsPresenter {
    
    //MARK: - Words details fetching
    func fetchWordDetails() {
        controller?.startLoading()
        
        networkManager.getWordDetailsById(id: model.id) {[weak self] (detailsArray, error) in
            guard let unwrappedSelf = self,
                let detailsArray = detailsArray else { return }
            unwrappedSelf.privateWordDetailsModel = unwrappedSelf.wordDetailsMapper.mapWordMeaningDTOInViewModels(words: detailsArray)
            unwrappedSelf.controller?.setTable()
            unwrappedSelf.controller?.update()
            unwrappedSelf.controller?.finishLoading()
            
            if let error = error {
                print(error)
            }
        }
    }
    
    var wordModel: WordDetailsModel {
        get {
            return privateWordDetailsModel
        }
    }    
}
