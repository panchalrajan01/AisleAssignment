import UIKit

class MoreProfilesSectionView: UIView {
    
    public let firstProfileView: ProfileView = {
        let profileView = ProfileView()
        profileView.nameLabel.text = "Teena"
        return profileView
    }()
    
    public let secondProfileView: ProfileView = {
        let profileView = ProfileView()
        profileView.nameLabel.text = "Beena"
        return profileView
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
        addSubview(firstProfileView)
        addSubview(secondProfileView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            firstProfileView.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstProfileView.topAnchor.constraint(equalTo: topAnchor),
            firstProfileView.widthAnchor.constraint(equalToConstant: 168),
            firstProfileView.heightAnchor.constraint(equalToConstant: 255),
            
            secondProfileView.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondProfileView.topAnchor.constraint(equalTo: topAnchor),
            secondProfileView.widthAnchor.constraint(equalToConstant: 168),
            secondProfileView.heightAnchor.constraint(equalToConstant: 255),
        ])
    }
}
