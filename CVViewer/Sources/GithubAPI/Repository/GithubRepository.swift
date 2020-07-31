import Foundation

final class GithubRepository {
    
    private let requestExecutor: RequestExecutable
    
    init(executor: RequestExecutable = RequestExecutor()) {
        self.requestExecutor = executor
    }
    
    public func getGists(onSuccess: @escaping ([Gists]) -> Void,
                         onError: @escaping (String) -> Void) {
        
        let request = GithubAPI.GetGistsRequest()
        
        requestExecutor.run(request: request, onSuccess: onSuccess, onError: onError)
    }
    
    public func getResume(with gistId: String,
                          onSuccess: @escaping (Gist) -> Void,
                          onError: @escaping (String) -> Void) {
        
        let request = GithubAPI.GetResumeRequest(gistId: gistId)
        
        requestExecutor.run(request: request, onSuccess: onSuccess, onError: onError)
    }
    
}
