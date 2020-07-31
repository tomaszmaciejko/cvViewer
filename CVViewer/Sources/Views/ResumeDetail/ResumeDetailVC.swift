import UIKit

class ResumeDetailVC: UIViewController, ResumeDetailView {
    
    private var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private var collectionDirector: ResumeCollectionDirector!
    private var collectionView: UICollectionView!
    
    public var presenter: ResumeDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupView()
        setupConstraints()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewWillAppear()
    }
    
    public func showResume(_ resume: Resume) {
        collectionDirector.bind(resume)
    }
    
    public func setupView() {
        view.addSubview(loadingIndicator)
    }
    
    public func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    public func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    public func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionDirector = ResumeCollectionDirector(collectionView: collectionView)
        collectionDirector.setup()
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

private extension UIImageView {
    
    func imageWith(_ url: String) {
        guard let url = URL(string: url)
            else {
                return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage(data: data)
                }
            }
            
        }
    }
    
}
