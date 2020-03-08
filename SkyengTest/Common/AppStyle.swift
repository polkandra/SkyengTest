import UIKit

class AppStyle {
    
    static func applyUIElementsAppearances() {
        if #available(iOS 13.0, *) {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithOpaqueBackground()
            coloredAppearance.backgroundColor = mainAppColor
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
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
