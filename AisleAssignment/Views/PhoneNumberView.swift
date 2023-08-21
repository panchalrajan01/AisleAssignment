import UIKit

protocol PhoneNumberViewDelegate: AnyObject {
    func requestedForOTP()
}

class PhoneNumberView: UIView {
    
    weak var delegate: PhoneNumberViewDelegate?
    
    private lazy var getOTPLabel: UILabel = {
        let label = UILabel()
        label.text = "Get OTP"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var enterPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Your \nPhone Number"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var countryCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "+91"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        if let borderColor = UIColor(named: "BorderColor") {
            textField.layer.borderColor = borderColor.cgColor
        }
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    public lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "9999999999"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
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
        self.addSubview(getOTPLabel)
        self.addSubview(enterPhoneNumberLabel)
        self.addSubview(countryCodeTextField)
        self.addSubview(phoneNumberTextField)
        self.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            getOTPLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            getOTPLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            enterPhoneNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            enterPhoneNumberLabel.topAnchor.constraint(equalTo: getOTPLabel.bottomAnchor, constant: 8),
            
            countryCodeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            countryCodeTextField.topAnchor.constraint(equalTo: enterPhoneNumberLabel.bottomAnchor, constant: 12),
            countryCodeTextField.widthAnchor.constraint(equalToConstant: 64),
            countryCodeTextField.heightAnchor.constraint(equalToConstant: 36),
            
            phoneNumberTextField.leadingAnchor.constraint(equalTo: countryCodeTextField.trailingAnchor, constant: 8),
            phoneNumberTextField.topAnchor.constraint(equalTo: enterPhoneNumberLabel.bottomAnchor, constant: 12),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: 147),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 36),
            
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            continueButton.topAnchor.constraint(equalTo: countryCodeTextField.bottomAnchor, constant: 19),
            continueButton.widthAnchor.constraint(equalToConstant: 96),
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupEventHandlers() {
        continueButton.addTarget(self,action: #selector(continueButtonTapped),for: .touchUpInside);
    }
    
    @objc private func continueButtonTapped() {
        self.delegate?.requestedForOTP()
    }
}

