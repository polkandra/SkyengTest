import Foundation

enum LaunchInstructor {
    case main
    
    static func configure() -> LaunchInstructor {
        return .main
    }
}
