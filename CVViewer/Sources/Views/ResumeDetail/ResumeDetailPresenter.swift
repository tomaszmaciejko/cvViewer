import Foundation

final class ResumeDetailPresenter {
    
    private weak var view: ResumeDetailView?
    private let gistId: String
    private let dataRepository: GithubRepository
    
    init(view: ResumeDetailView, gistId: String, dataRepository: GithubRepository = .init()) {
        self.view = view
        self.gistId = gistId
        self.dataRepository = dataRepository
    }
    
    public func onViewWillAppear() {
        getResume(with: gistId)
    }
    
    private func showResume(_ resume: Resume) {
        self.view?.showResume(resume)
    }
    
    private func getResume(with gistId: String) {
        dataRepository.getResume(with: gistId,
                                 onSuccess: { [weak self] gist in
                                    let resumeJSON = gist.files.values.first
                                    if let content = resumeJSON?.content {
                                        let data = Data(content.utf8)
                                        let decoder = JSONDecoder()

                                        do {
                                            let resume = try decoder.decode(Resume.self, from: data)
                                            DispatchQueue.main.async {
                                                self?.showResume(resume)
                                            }
                                        } catch {
                                            print("Failed to decode JSON", error)
                                        }
                                    }
        }, onError: { [weak self] error in
                     DispatchQueue.main.async {
                        self?.view?.hideLoadingIndicator()
                        self?.view?.showError("Oooops. Something went wrong.")
                    }
        })
    }
}

private extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
