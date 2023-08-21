import UIKit

class VerifyOTPViewController: UIViewController {
    
    private let verifyOTPView = VerifyOTPView()
    private let countryCode: String
    private let phoneNumber: String
    
    private var countdownTimer: Timer?
    private var remainingSeconds = 59
    
    init(countryCode: String, phoneNumber: String) {
        self.countryCode = countryCode
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegates()
        setupConstraints()
        startTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Stop Timer when view is changed
        countdownTimer?.invalidate()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(verifyOTPView)
        
        verifyOTPView.contactNumberLabel.text = countryCode + " " + phoneNumber
    }
    
    private func setupDelegates() {
        verifyOTPView.delegate = self
        verifyOTPView.otpCodeTextField.delegate = self
    }
    
    private func setupConstraints() {
        verifyOTPView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            verifyOTPView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            verifyOTPView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            verifyOTPView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            verifyOTPView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func startTimer() {
        countdownTimer?.invalidate()
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
                let minutes = self.remainingSeconds / 60
                let seconds = self.remainingSeconds % 60
                let timeString = String(format: "%02d:%02d", minutes, seconds)
                self.verifyOTPView.timeRemainingCounterLabel.text = timeString
            } else {
                AlertManager.shared.showAlertWithAction(title: "OTP Not Received", message: "Please try after some time", actionTitle: "Go Back") { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.navigationController?.popViewController(animated: true)
                }
                countdownTimer?.invalidate()
                countdownTimer = nil
            }
        }
    }
}

extension VerifyOTPViewController: VerifyOTPViewDelegate {
    func requestedToVerifyOTP() {
        guard let otp = verifyOTPView.otpCodeTextField.text, !otp.isEmpty else {
            AlertManager.shared.showAlert(title: "Empty OTP Field", message: "OTP Field can not be Empty")
            return
        }
        
        if otp.count != 4 {
            AlertManager.shared.showAlert(title: "Invalid OTP", message: "OTP should be of 4 Characters")
            return
        }

        let otpDataResource = OTPDataResource()
        let phoneNumberWithCountryCode = countryCode + phoneNumber
        let otpAPIRequest = OTPApiRequest(number: phoneNumberWithCountryCode, otp: otp)
        otpDataResource.postOTP(otpWithPhoneNumber: otpAPIRequest) { [weak self] result in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                guard let result = result else {
                    AlertManager.shared.showAlert(title: "Server Error", message: "No response from Server")
                    return
                }

                guard let token = result.token else {
                    AlertManager.shared.showAlert(title: "Internal Error", message: "Unable to proceed with Verification")
                    return
                }

                let tabbarViewController = MainTabBarController(token: token)
                self.navigationController?.pushViewController(tabbarViewController, animated: true)
            }
        }
        

    }
    
    func requestedToEditPhoneNumber() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension VerifyOTPViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let allowedCharacterSet = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: characterSet) && textField.text!.count + string.count <= 4
    }
}
