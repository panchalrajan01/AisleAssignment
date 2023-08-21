import UIKit

class AlertManager {
    static let shared = AlertManager()
    
    private init() {}
    
    private func getRootViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        return windowScene.windows.first?.rootViewController
    }
    
    func showAlert(title: String, message: String? = nil) {
        guard let rootViewController = getRootViewController() else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        rootViewController.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithAction(title: String, message: String, actionTitle: String, actionHandler: @escaping () -> Void) {
        guard let rootViewController = getRootViewController() else {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            actionHandler()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(action)
        alertController.addAction(cancelAction)
        rootViewController.present(alertController, animated: true, completion: nil)
    }
}
