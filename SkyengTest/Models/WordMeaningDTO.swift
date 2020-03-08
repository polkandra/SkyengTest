
import Foundation

// MARK: - WordMeaningElement
struct WordMeaningDTO: Decodable {
    let id: String
    let wordId: Int
    let partOfSpeechCode: String
    let text, soundUrl, transcription: String
    let properties: Properties
    let updatedAt: String
    let translation: WordMeaningTranslation
    let images: [Image]
    let definition: Definition
    let examples: [Definition]
    let meaningsWithSimilarTranslation: [MeaningsWithSimilarTranslation]
    let alternativeTranslations: [AlternativeTranslation]
}

// MARK: - AlternativeTranslation
struct AlternativeTranslation: Decodable {
    let text: String
    let translation: Translation
}

// MARK: - Translation
struct WordMeaningTranslation: Decodable {
    let text: String
}

// MARK: - Definition
struct Definition: Decodable {
    let text: String
    let soundUrl: String?
}

// MARK: - Image
struct Image: Decodable {
    let url: String
}

// MARK: - MeaningsWithSimilarTranslation
struct MeaningsWithSimilarTranslation: Decodable {
    let meaningId: Int
    let frequencyPercent, partOfSpeechAbbreviation: String
    let translation: Translation
}

// MARK: - Properties
struct Properties: Decodable {
}
