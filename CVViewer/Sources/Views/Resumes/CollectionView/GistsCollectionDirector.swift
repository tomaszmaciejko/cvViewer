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
        collectionView?.register(GistListCell.self, forCellWithReuseIdentifier: "GistListCell")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GistListCell", for: indexPath)
        if let cell = cell as? GistListCell {
            cell.fullName = items[indexPath.row].files.keys.first
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
