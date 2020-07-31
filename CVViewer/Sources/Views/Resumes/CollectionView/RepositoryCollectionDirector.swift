import UIKit

final class GistsCollectionDirector: NSObject {
    
    public var onSelectItem: ((String) -> Void)?
    
    private weak var collectionView: UICollectionView?
    
    private var items: [Gists] = []
    private let numberOfSections = 1
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    public func setup() {
        let nib = UINib(nibName: "RepositoryListCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "RepositoryListCell")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 375, height: 40)
        }
        
    }
    
    public func bind(_ items: [Gists]) {
        self.items = items
        collectionView?.reloadData()
    }
    
}

extension GistsCollectionDirector: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepositoryListCell", for: indexPath)
        if let cell = cell as? RepositoryListCell {
            cell.fullName = items[indexPath.row].gistId
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}

extension GistsCollectionDirector: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gist = items[indexPath.row]
        onSelectItem?(gist.gistId)
    }
}
