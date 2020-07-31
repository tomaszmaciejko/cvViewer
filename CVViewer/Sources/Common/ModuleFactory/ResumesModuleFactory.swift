protocol ResumesModuleFactory {
    func makeResumeListModule() -> ResumesView
    func makeResumeDetailModule(with gistId: String) -> ResumeDetailView
}
