import UIKit

class UpgradeSectionView: UIView {
    
    private lazy var interestedLabel: UILabel = {
        let label = UILabel()
        label.text = "Interested In You"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var premiumLabel: UILabel = {
        let label = UILabel()
        label.text = "Premium members can\nview all their likes at once"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15)
        if let textColor = UIColor(named: "TextColor") {
            label.textColor = textColor
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var upgradeButton: CapsuleButton = {
        let button = CapsuleButton(title: "Upgrade")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.addSubview(interestedLabel)
        self.addSubview(premiumLabel)
        self.addSubview(upgradeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            interestedLabel.topAnchor.constraint(equalTo: topAnchor),
            interestedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            premiumLabel.topAnchor.constraint(equalTo: interestedLabel.bottomAnchor, constant: 5),
            premiumLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            upgradeButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            upgradeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            upgradeButton.widthAnchor.constraint(equalToConstant: 113),
            upgradeButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
