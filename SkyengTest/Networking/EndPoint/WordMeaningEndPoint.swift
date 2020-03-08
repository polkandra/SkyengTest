
import Foundation

public enum WordMeaningApi {
    case meaning(id: Int)
}

extension WordMeaningApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: Constants.baseURL) else { fatalError("baseURL could not be configured.") }
        
        return url
    }
    
    var path: String {
        switch self {
        case .meaning:
            return "/v1/meanings"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .meaning(let meaningId):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters:
                ["_format" : "json",
                "ids" : meaningId])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
