import UIKit

class GistListCell: UICollectionViewCell {

    private var fullNameLabel: UILabel = UILabel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var fullName: String? = ""{
        didSet {
            fullNameLabel.text = fullName
        }
    }
    
    private func setupView() {
        addSubview(fullNameLabel)
    }
    
    private func setupConstraints() {
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        fullNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fullNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
