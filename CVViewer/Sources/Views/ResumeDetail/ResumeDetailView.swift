protocol ResumeDetailView: class, Presentable {
    func showResume(_ resume: Resume)
    func showError(_ message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator() 
}
