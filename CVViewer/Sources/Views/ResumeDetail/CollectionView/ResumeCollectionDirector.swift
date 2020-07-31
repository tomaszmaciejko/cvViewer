import UIKit

final class ResumeCollectionDirector: NSObject {
        
    private weak var collectionView: UICollectionView?
    
    private var resume: Resume?
    private let numberOfSections = 1
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    public func setup() {
        collectionView?.register(ResumeSummaryCell.self, forCellWithReuseIdentifier: "ResumeSummaryCell")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
//        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.itemSize = CGSize(width: 375, height: 40)
//        }
        
    }
    
    public func bind(_ item: Resume) {
        self.resume = item
        collectionView?.reloadData()
    }
    
}

extension ResumeCollectionDirector: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResumeSummaryCell", for: indexPath)
        if let cell = cell as? ResumeSummaryCell, let resume = self.resume {
            cell.bind(resume)
           // cell.fullName = items[indexPath.row].gistId
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resume != nil ? 1 : 0// items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 800)
    }
    
}
