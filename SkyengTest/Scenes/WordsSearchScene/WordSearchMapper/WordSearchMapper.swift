
import Foundation

protocol WordSearchMapper: class {
    func mapWordsDTOInViewModels(words: [WordDTO]) -> [WordsSearchModel]
}

class WordSearchMapperImp {
    
}

extension WordSearchMapperImp: WordSearchMapper {
    func mapWordsDTOInViewModels(words: [WordDTO]) -> [WordsSearchModel] {
        let wordsModels = words.map {WordsSearchModel(title: $0.text, id: $0.meanings.first?.id ?? 0)}
        return wordsModels
    }
}
