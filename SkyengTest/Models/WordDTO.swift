
import Foundation

// MARK: - WordElement
struct WordDTO: Decodable {
    let id: Int
    let text: String
    let meanings: [Meaning]
}

// MARK: - Meaning
struct Meaning: Decodable {
    let id: Int
    let partOfSpeechCode: String
    let translation: Translation
    let previewURL, imageURL: String?
    let transcription: String
    let soundURL: String?
}

// MARK: - Translation
struct Translation: Decodable {
    let text: String
    let note: String?
}
