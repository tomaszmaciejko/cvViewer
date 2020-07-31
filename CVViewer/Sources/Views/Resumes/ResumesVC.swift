import UIKit

final class ResumesVC: UIViewController, ResumesView {
    
    public var presenter: ResumesPresenter!
    public var onNext: ((String) -> Void)?
    
    private var collectionView: UICollectionView!
    private var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private var collectionDirector: GistsCollectionDirector!
    private let searchController = UISearchController(searchResultsController: nil)
    private let searchResultUpdater = SearchResultUpdater()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewWillAppear()
        
    }
    
    public func show(resumes: [Gists]) {
        collectionDirector.bind(resumes)
    }
    
    public func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
    
    public func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    public func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    private func setupViews() {
        setupCollectionView()
        setupSearchController()
        setupView()
        setupConstraints()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = searchResultUpdater
        searchResultUpdater.onSearchResultUpdate = { [weak self] text in
            self?.presenter.onSearchResultUpdate(text)
        }
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Files"
        navigationItem.searchController = searchController
    }
    
    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionDirector = GistsCollectionDirector(collectionView: collectionView)
        collectionDirector.setup()
        collectionDirector.onSelectItem = onNext
    }
    
    private func setupView() {
        navigationItem.title = "Resume list"
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        view.addSubview(loadingIndicator)
    }
    
    private func setupConstraints() {
        setupCollectionViewConstraints()
        setupLoadingIndicatorConstraints()
    }
   
    private func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .orange
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupLoadingIndicatorConstraints() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

class SearchResultUpdater: NSObject, UISearchResultsUpdating {
    
    public var onSearchResultUpdate: ((String) -> Void)?
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text
            else {
                return
        }
        onSearchResultUpdate?(text)
    }
}
