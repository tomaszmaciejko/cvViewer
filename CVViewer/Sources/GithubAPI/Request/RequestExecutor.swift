import Foundation

enum URLSessionTaskError: Error {
    case responseError(Error)
    case connectionError(Error)
}

protocol RequestExecutable {
   func run<T: Request>(request: T,
                        onSuccess: @escaping (T.Response) -> Void,
                        onError: @escaping (String) -> Void)
}

final class RequestExecutor: RequestExecutable {

    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    public func run<T: Request>(request: T,
                                onSuccess: @escaping (T.Response) -> Void,
                                onError: @escaping (String) -> Void) {
        
        _ = send(request) { response in
                switch response {
                case .success(let value):
                    onSuccess(value)
                case .failure(let error):
                    onError(error.localizedDescription)
                }
            }
    }
    
    private func send<T: Request>(_ request: T, handler:
        @escaping (Result<T.Response, URLSessionTaskError>) -> Void = { _ in }) -> URLSessionDataTask? {
        
        let urlRequest: URLRequest
        urlRequest = request.buildURLRequest()
        
        let task = urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            let result: Result<T.Response, URLSessionTaskError>
            
            switch (data, urlResponse, error) {
            case (_, _, let error?):
                result = .failure(.connectionError(error))
                
            case (let data?, let urlResponse as HTTPURLResponse, _):
                do {
                    let response = try request.response(from: data, urlResponse: urlResponse)
                    result = .success(response)
                } catch {
                    result = .failure(.responseError(error))
                }
                
            default:
                result = .failure(.responseError(ResponseError.nonHTTPURLResponse(urlResponse)))
            }
            
            handler(result)
            
        }
        
        task.resume()
        
        return task
    }
    
}
