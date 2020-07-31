import UIKit

public class ResumeSummaryCell: UICollectionViewCell {
    private var cvLabel: UILabel = UILabel()
    private var nameLabel: UILabel = UILabel()
    private var portraitImageView: UIImageView = UIImageView()
    private var personalDetailsLabel: UILabel = UILabel()
    private var addressLabel: UILabel = UILabel()
    private var dateOfBirthLabel: UILabel = UILabel()
    private var phoneNumberLabel: UILabel = UILabel()
    private var emailLabel: UILabel = UILabel()
    private var genderLabel: UILabel = UILabel()
    private var summaryLabel: UILabel = UILabel()
    
    private var addressDescriptionLabel: UILabel = UILabel()
    private var dateOfBirthDescriptionLabel: UILabel = UILabel()
    private var phoneNumberDescriptionLabel: UILabel = UILabel()
    private var emailDescriptionLabel: UILabel = UILabel()
    private var genderDescriptionLabel: UILabel = UILabel()
    private var summaryDescriptionLabel: UILabel = UILabel()
    
    private var personalInformationStackView: UIStackView = UIStackView()
    private var personalInformationLabelsStackView: UIStackView = UIStackView()
    private var resumeStackView: UIStackView = UIStackView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupViews()
        setupConstraints()
        setupTexts()
    }
    
    private func setupViews() {
        
        addSubview(cvLabel)
        addSubview(nameLabel)
        addSubview(portraitImageView)
        addSubview(resumeStackView)
   
        addSubview(personalDetailsLabel)
                
        let genderRow = createRowWithLabels(first: genderDescriptionLabel, second: genderLabel)
        resumeStackView.addArrangedSubview(genderRow)
        
        let addressRow = createRowWithLabels(first: addressDescriptionLabel, second: addressLabel)
        resumeStackView.addArrangedSubview(addressRow)
        
        let dotRow = createRowWithLabels(first: dateOfBirthDescriptionLabel, second: dateOfBirthLabel)
        resumeStackView.addArrangedSubview(dotRow)
        
        let phoneNumberRow = createRowWithLabels(first: phoneNumberDescriptionLabel, second: phoneNumberLabel)
        resumeStackView.addArrangedSubview(phoneNumberRow)
        
        let emailRow = createRowWithLabels(first: emailDescriptionLabel, second: emailLabel)
        resumeStackView.addArrangedSubview(emailRow)
        
        let summaryRow = createRowWithLabels(first: summaryDescriptionLabel, second: summaryLabel)
        resumeStackView.addArrangedSubview(summaryRow)
                
        personalInformationStackView.axis = .vertical
        personalInformationLabelsStackView.axis = .vertical
        
        resumeStackView.axis = .vertical
        
        summaryLabel.numberOfLines = 0
        
    }
    
    private func setupTexts() {
        cvLabel.text = "Resume"
        personalDetailsLabel.text = "Personal details"
        
        addressDescriptionLabel.text = "Address:"
        dateOfBirthDescriptionLabel.text = "Date of birth:"
        phoneNumberDescriptionLabel.text = "Phone number: "
        emailDescriptionLabel.text = "E-mail: "
        genderDescriptionLabel.text = "Gender: "
        summaryDescriptionLabel.text = "Summary: "
    }
    
    private func setupConstraints() {
        cvLabel.translatesAutoresizingMaskIntoConstraints = false
        cvLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cvLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: cvLabel.bottomAnchor, constant: 16).isActive = true
        
        portraitImageView.translatesAutoresizingMaskIntoConstraints = false
        portraitImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        portraitImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        portraitImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        portraitImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16).isActive = true
        
        personalDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        personalDetailsLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        personalDetailsLabel.topAnchor.constraint(equalTo: portraitImageView.bottomAnchor, constant: 16).isActive = true
        
        resumeStackView.translatesAutoresizingMaskIntoConstraints = false
        resumeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        resumeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        resumeStackView.topAnchor.constraint(equalTo: personalDetailsLabel.bottomAnchor, constant: 16).isActive = true
    }
    
    private func createRowWithLabels(first: UILabel, second: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        first.widthAnchor.constraint(equalToConstant: 120).isActive = true
        styleDescriptionLabel(first)
        styleContentLabel(second)
        stackView.addArrangedSubview(first)
        stackView.addArrangedSubview(second)
        return stackView
    }
    
    private func styleDescriptionLabel(_ label: UILabel) {
        label.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    private func styleContentLabel(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 14)
    }
}

extension ResumeSummaryCell {
    public func bind(_ resume: Resume) {
        self.nameLabel.text = resume.firstName + " " + resume.lastName
        self.addressLabel.text = resume.address
        self.dateOfBirthLabel.text = resume.dateOfBirth
        self.phoneNumberLabel.text = resume.phoneNumber
        self.emailLabel.text = resume.email
        self.genderLabel.text = resume.gender
        self.summaryLabel.text = resume.summary
        if let url = URL(string: resume.photoUrl), let data = try? Data(contentsOf: url) {
            self.portraitImageView.image = UIImage(data: data)
        }
    }
}
