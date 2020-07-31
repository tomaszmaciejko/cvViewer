protocol ResumesView: class, Presentable {
    var onNext: ((String) -> Void)? { get set }
    
    func show(resumes: [Gists])
    func showError(_ message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator() 
}
