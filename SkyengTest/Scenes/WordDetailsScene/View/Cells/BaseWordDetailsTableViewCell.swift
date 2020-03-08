
import UIKit

class BaseWordDetailsTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var wordPicture: UIImageView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var transcriptionLabel: UILabel!
    @IBOutlet weak var longDefinitionLabel: UILabel!
    @IBOutlet weak var firstExampleLabel: UILabel!
    @IBOutlet weak var secondExampleLabel: UILabel!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = AppStyle.mainAppColor
        containerView.backgroundColor = AppStyle.mainAppColor
    }
    
    func configureSelf(with model: WordDetailsModel) {
        
        var transcription: String {
            var text = ""
            if model.transcription == "" {
                text = "Транскипция отсутствует"
            } else {
                text = "/ \(model.transcription) /"
            }
            
            return text
        }
        
        wordPicture.imageFromServerURL(model.image ?? "")
        wordLabel.text = model.title
        definitionLabel.text = model.firstTranslation
        transcriptionLabel.text = transcription
        longDefinitionLabel.text = model.definition
        firstExampleLabel.text = model.exampleFirstText
        secondExampleLabel.text = model.exampleSecondText
    }
}
