import Foundation

final class ResumesPresenter {
    
    private weak var view: ResumesView?
    private let dataRepository: GithubRepository
    
    private var githubGists: [Gists] = []
    
    init(view: ResumesView, dataRepository: GithubRepository = .init()) {
        self.view = view
        self.dataRepository = dataRepository
    }
    
    public func onViewWillAppear() {
        if githubGists.isEmpty {
            getGists()
        }
    }
    
    public func onSearchResultUpdate(_ text: String?) {
        showResumesContaining(text)
    }
    
    private func showResumesContaining(_ text: String?) {
        var filteredResumes: [Gists]
 
        if let text = text, !text.isEmpty {
            filteredResumes = DataFilter.searchResults(githubGists, text)
        } else {
            filteredResumes = githubGists
        }

        let limitedResumes = DataFilter.limitResults(filteredResumes)
        view?.show(resumes: limitedResumes)
    }
    
    private func filterContentForSearchText(_ searchText: String) -> [Gists] {
        let filteredRepos = githubGists.filter({( repo: Gists) -> Bool in
            return repo.description.lowercased().contains(searchText.lowercased())
        })
        return filteredRepos
    }
    
    private func getGists() {
        view?.showLoadingIndicator()
        
        dataRepository.getGists(onSuccess: { [weak self] gists in
            DispatchQueue.main.async {
                self?.githubGists = gists
                self?.showResumesContaining(nil)
                self?.view?.hideLoadingIndicator()
            }
        }, onError: { [weak self] error in
            DispatchQueue.main.async {
            self?.view?.hideLoadingIndicator()
            self?.view?.showError("Oooops. Something went wrong.")
            }
        })
    }
    
}
