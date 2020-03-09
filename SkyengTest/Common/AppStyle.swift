import UIKit

class AppStyle {
    
    static func applyUIElementsAppearances() {
        if #available(iOS 13.0, *) {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithOpaqueBackground()
            coloredAppearance.backgroundColor = mainAppColor
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            coloredAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "back"), transitionMaskImage: #imageLiteral(resourceName: "back"))
            
            let backButtonAppearence = UIBarButtonItemAppearance()
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
            backButtonAppearence.normal.titleTextAttributes = titleTextAttributes
            backButtonAppearence.highlighted.titleTextAttributes = titleTextAttributes
            coloredAppearance.backButtonAppearance = backButtonAppearence
        }
    }
    
    //Colors
    static let mainAppColor = UIColor.mainColor
    
    //Fonts
    static let tableFont = UIFont.tableFont
}

extension UIColor {
    
    static var mainColor: UIColor {
        return UIColor(hex: "#070707")
    }
}

extension UIFont {
    
    static var tableFont: UIFont {
        return UIFont(name: "Avenir", size: 20)!
    }
}
