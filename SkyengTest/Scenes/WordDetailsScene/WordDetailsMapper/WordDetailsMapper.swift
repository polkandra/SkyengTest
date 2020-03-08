
import Foundation

protocol WordDetailsMapper: class {
    func mapWordMeaningDTOInViewModels(words: [WordMeaningDTO]) -> WordDetailsModel
}

class WordDetailsMapperImp {
    
}

extension WordDetailsMapperImp: WordDetailsMapper {
    func mapWordMeaningDTOInViewModels(words: [WordMeaningDTO]) -> WordDetailsModel {
        let wordsModels = words.map { (details) -> WordDetailsModel in
            let imgURLString = Constants.prefix + (details.images.first?.url ?? "")
            let translationSoundURLString = Constants.prefix + (details.soundUrl)
            let translationSoundURL = URL(string: translationSoundURLString)
            let exampleFirstSoundUrlString = Constants.prefix + (details.examples.first?.soundUrl ?? "")
            let exampleFirstSoundUrl = URL(string: exampleFirstSoundUrlString)
            let exampleSecondSoundUrlString = Constants.prefix + (details.examples.last?.soundUrl ?? "")
            let exampleSecondSoundUrl = URL(string: exampleSecondSoundUrlString)
            
            let model = WordDetailsModel(image: imgURLString,
                                         title: details.text,
                                         firstTranslation: details.translation.text,
                                         translationSoundURL: translationSoundURL,
                                         transcription: details.transcription,
                                         definition: details.definition.text,
                                         exampleFirstText: details.examples.first?.text ?? "",
                                         exampleSecondText: details.examples.last?.text ?? "",
                                         exampleFirstSoundURL: exampleFirstSoundUrl,
                                         exampleSecondSoundURL: exampleSecondSoundUrl)
            return model
        }
        
        return wordsModels.first!
    }
}
