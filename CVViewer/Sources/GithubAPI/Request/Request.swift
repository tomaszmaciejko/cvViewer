import Foundation

public enum HTTPMethod: String {
    
    case get
    
    case post
    
    case put
    
    case head
    
    case delete
    
    case patch
    
}

public enum HTTPContentType: String {
    case textHtml = "text/html"
    case json = "application/json"
}

public enum ResponseError: Error {
    case nonHTTPURLResponse(URLResponse?)
    case unacceptableStatusCode(Int)
    case unexpectedObject(Any)
}

struct HTTPHeader {
    struct Key {
        static let accept: String = "Accept"
        static let contentType: String = "Content-Type"
        static let cacheControl: String = "Cache-Control"
    }
    
    struct Value {
        static func contentType(_ type: HTTPContentType) -> String {
            return type.rawValue
        }
    }
}

public protocol Request {
    
    /// The response type associated with the request type.
    associatedtype Response
    
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Any? { get }
    var queryParameters: [String: String]? { get }
    var headerFields: [String: String] { get }
    
    /// Build `Response` instance from raw response object.
    /// - Throws: `Error`
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response
    
    func buildURLRequest() -> URLRequest
}

public extension Request {
    
    var baseURL: URL {
        guard let url = URL(string: ConfigProvider.baseURL) else {
            fatalError("Not possible to create url from string: \(ConfigProvider.baseURL)")
        }
        return url
    }
    
    var parameters: Any? {
        return nil
    }
    
    var queryParameters: [String: String]? {
        guard let parameters = parameters as? [String: String] else {
            return nil
        }
        
        return parameters
    }
    
    var headerFields: [String: String] {
        return [:]
    }
    
    /// Builds `URLRequest` from properties of `self`.
    /// - Throws: `RequestError`, `Error`
    func buildURLRequest() -> URLRequest {
        let url = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        
        print("url: \(url)")
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            fatalError("Invalid Base URL")
        }
        
        var urlRequest = URLRequest(url: url)
        
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            components.queryItems = queryParameters.map {
                URLQueryItem(name: $0.0, value: $0.1)
            }
        }
        
        urlRequest.url = components.url
        urlRequest.httpMethod = method.rawValue
        
        headerFields.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
}

extension Request where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data, let parsedObject = try? JSONSerialization.jsonObject(with: data)
            else {
                throw ResponseError.unexpectedObject(object)
        }
        
        if parsedObject is [String: Any] || parsedObject is [[String: Any]] {
            do {                
                return try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("Mapping error:\n\n\(error) for object: \(object)")
                throw error
            }
        }
        
        if object is Data, let responseObject = object as? Response {
            return responseObject
        }
        
        throw ResponseError.unexpectedObject(object)
    }
}
