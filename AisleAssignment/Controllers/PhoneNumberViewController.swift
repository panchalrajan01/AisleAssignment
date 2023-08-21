import UIKit

class PhoneNumberViewController: UIViewController {

    private let phoneNumberView = PhoneNumberView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegates()
        setupConstraints()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(phoneNumberView)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupDelegates() {
        phoneNumberView.delegate = self
        phoneNumberView.countryCodeTextField.delegate = self
        phoneNumberView.phoneNumberTextField.delegate = self
    }
    
    private func setupConstraints() {
        phoneNumberView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            phoneNumberView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            phoneNumberView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            phoneNumberView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            phoneNumberView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension PhoneNumberViewController: PhoneNumberViewDelegate {
    func requestedForOTP() {
        guard let countryCode = phoneNumberView.countryCodeTextField.text, !countryCode.isEmpty else {
            AlertManager.shared.showAlert(title: "Empty Country Code", message: "Country Code Field can not be Empty")
            return
        }
        
        guard let phoneNumber = phoneNumberView.phoneNumberTextField.text, !phoneNumber.isEmpty else {
            AlertManager.shared.showAlert(title: "Empty Phone Number", message: "Phone Number Field can not be Empty")
            return
        }
        
        let isValidCountryCode = validate(phoneNumberView.countryCodeTextField)
        let isValidPhoneNumber = validate(phoneNumberView.phoneNumberTextField)
        
        if isValidCountryCode && isValidPhoneNumber {
            let phoneDataResource = PhoneDataResource()
            let phoneNumberWithCountryCode = countryCode + phoneNumber
            let phoneAPIRequest = PhoneAPIRequest(number: phoneNumberWithCountryCode)

            phoneDataResource.postPhoneNumber(phoneRequest: phoneAPIRequest) { [weak self] result in
                guard let self = self else {
                    return
                }

                DispatchQueue.main.async {
                    guard let result = result else {
                        AlertManager.shared.showAlert(title: "Server Error", message: "No response from Server")
                        return
                    }

                    if result.status {
                        let verifyOTPViewController = VerifyOTPViewController(countryCode: countryCode, phoneNumber: phoneNumber)
                        self.navigationController?.pushViewController(verifyOTPViewController, animated: true)
                    } else {
                        AlertManager.shared.showAlert(title: "Internal Error", message: "Unable to proceed with Verification")
                    }
                }
            }
        }

    }
    
    private func validate(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            AlertManager.shared.showAlert(title: "Internal Error", message: "Please Contact Support Team")
            return false
        }
        
        switch textField {
        case phoneNumberView.countryCodeTextField:
            if !(1...4).contains(text.count) {
                AlertManager.shared.showAlert(title: "Invalid Country Code", message: "Country Code should be of Length 1 to 3")
                return false
            }
            
        case phoneNumberView.phoneNumberTextField:
            if text.count != 10 {
                AlertManager.shared.showAlert(title: "Invalid Phone Number", message: "Phone Number should be of Length 10")
                return false
            }
            
        default:
            break
        }
        
        return true
    }
}

extension PhoneNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        // In Country Code Text Field it allows only + at starting, then max 3 Numbers and Backspace
        if textField == phoneNumberView.countryCodeTextField {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            if string.isEmpty {
                return true
            }
            
            if newText == "+" {
                return true
            }
            
            if newText.first == "+",
               newText.dropFirst().allSatisfy({ $0.isNumber }),
               newText.count <= 4 {
                return true
            }
            
            return false
            
            // Allow up to 10 numeric characters for phoneNumberTextField
        } else if textField == phoneNumberView.phoneNumberTextField {
            let allowedCharacterSet = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: characterSet) && textField.text!.count + string.count <= 10
        }
        
        return true
    }
}
