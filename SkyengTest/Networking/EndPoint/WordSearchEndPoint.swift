
import Foundation

public enum WordSearchApi {
    case word(name: String)
}

extension WordSearchApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: Constants.baseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .word:
             return "/v1/words/search"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .word(let text):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters:
                ["_format" : "json",
                "search" : text])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
