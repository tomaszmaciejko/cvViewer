import Foundation

final class GithubAPI {
    
    private init() {}
    
    struct GetGistsRequest: Request {
        
        public typealias Response = [Gists]
                
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/gists"
        }
        
        public var headerFields: [String: String] {
            let headers: [String: String] = [
                HTTPHeader.Key.accept: "application/vnd.github.v3+json"
            ]
            return headers
        }
    }
    
    struct GetResumeRequest: Request {
            
            public typealias Response = Gist
                    
            var baseURL: URL {
                guard let url = URL(string: ConfigProvider.gistsUrl) else {
                    fatalError("Not possible to create url from string: \(ConfigProvider.gistsUrl)")
                }
                return url
            }
            
            public var gistId: String
        
            public var method: HTTPMethod {
                return .get
            }
            
            public var path: String {
                return "/gists/\(gistId)"
            }
            
            public var headerFields: [String: String] {
                let headers: [String: String] = [
                    HTTPHeader.Key.accept: "application/vnd.github.v3+json"
                ]
                return headers
            }
        }
}
