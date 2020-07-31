final class AnyModuleFactory: ResumesModuleFactory {
    public func makeResumeListModule() -> ResumesView {
        let resumesView = ResumesVC()
        let presenter = ResumesPresenter(view: resumesView)
        resumesView.presenter = presenter
        return resumesView
    }
    
    public func makeResumeDetailModule(with gistId: String) -> ResumeDetailView {
        let resumeDetailView = ResumeDetailVC()
        let presenter = ResumeDetailPresenter(view: resumeDetailView, gistId: gistId)
        resumeDetailView.presenter = presenter
        return resumeDetailView
    }

}
