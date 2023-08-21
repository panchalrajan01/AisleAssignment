import UIKit

class UserInfoSectionView: UIView {
    
    public lazy var squareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "thumb")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public lazy var nameAndAgeLabel: UILabel = {
        let label = UILabel()
        label.text = "Meena, 23"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap to review 50+ notes"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.addSubview(squareImageView)
        self.addSubview(nameAndAgeLabel)
        self.addSubview(ratingLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            squareImageView.topAnchor.constraint(equalTo: topAnchor),
            squareImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            squareImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            squareImageView.heightAnchor.constraint(equalTo: heightAnchor),
            
            nameAndAgeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameAndAgeLabel.bottomAnchor.constraint(equalTo: squareImageView.bottomAnchor, constant: -39),
            
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ratingLabel.bottomAnchor.constraint(equalTo: squareImageView.bottomAnchor, constant: -15),
        ])
    }
}
