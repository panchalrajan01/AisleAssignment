import UIKit

protocol VerifyOTPViewDelegate: AnyObject {
    func requestedToVerifyOTP()
    func requestedToEditPhoneNumber()
}

class VerifyOTPView: UIView {
    
    weak var delegate: VerifyOTPViewDelegate?

    public lazy var contactNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "+91 9999999999"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editContactDetails: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var enterOTPLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter The \nOTP"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var otpCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "9999"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        if let borderColor = UIColor(named: "BorderColor") {
            textField.layer.borderColor = borderColor.cgColor
        }
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var continueButton: CapsuleButton = {
        let button = CapsuleButton(title: "Continue")
        return button
    }()
    
    public lazy var timeRemainingCounterLabel: UILabel = {
        let label = UILabel()
        label.text = "00:59"
        label.font = UIFont.boldSystemFont(ofSize: 14)
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
        setupEventHandlers()
    }
    
    private func setupView() {
        self.addSubview(contactNumberLabel)
        self.addSubview(editContactDetails)
        self.addSubview(enterOTPLabel)
        self.addSubview(otpCodeTextField)
        self.addSubview(continueButton)
        self.addSubview(timeRemainingCounterLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            contactNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            contactNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80),

            editContactDetails.leadingAnchor.constraint(equalTo: contactNumberLabel.trailingAnchor, constant: 7),
            editContactDetails.topAnchor.constraint(equalTo: topAnchor, constant: 84),
            editContactDetails.widthAnchor.constraint(equalToConstant: 14),
            editContactDetails.heightAnchor.constraint(equalToConstant: 14),

            enterOTPLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            enterOTPLabel.topAnchor.constraint(equalTo: contactNumberLabel.bottomAnchor, constant: 8),
            
            otpCodeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            otpCodeTextField.topAnchor.constraint(equalTo: enterOTPLabel.bottomAnchor, constant: 12),
            otpCodeTextField.widthAnchor.constraint(equalToConstant: 78),
            otpCodeTextField.heightAnchor.constraint(equalToConstant: 36),
            
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            continueButton.topAnchor.constraint(equalTo: otpCodeTextField.bottomAnchor, constant: 19),
            continueButton.widthAnchor.constraint(equalToConstant: 96),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            
            timeRemainingCounterLabel.leadingAnchor.constraint(equalTo: continueButton.trailingAnchor, constant: 12),
            timeRemainingCounterLabel.topAnchor.constraint(equalTo: otpCodeTextField.bottomAnchor, constant: 30)
        ])
    }
    
    private func setupEventHandlers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editContactDetailsTapped))
        editContactDetails.isUserInteractionEnabled = true
        editContactDetails.addGestureRecognizer(tapGestureRecognizer)
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }

    @objc private func editContactDetailsTapped() {
        self.delegate?.requestedToEditPhoneNumber()
    }

    @objc private func continueButtonTapped() {
        self.delegate?.requestedToVerifyOTP()
    }
}
