import Foundation

struct OTPDataResource {

    func postOTP(otpWithPhoneNumber: OTPApiRequest,
                 completionHandler: @escaping (_ result: OTPAPIResponse?) -> Void) {
        let otpAPIEndPoint = APIManager.shared.getAPIURL(endpoint: .otpVerify)
        guard let otpURLVerify = URL(string: otpAPIEndPoint) else {
            AlertManager.shared.showAlert(title: "Internal Error", message: "Please Contact Support Team")
            return
        }
        do {
            let otpAPIPostBody = try JSONEncoder().encode(otpWithPhoneNumber)
            HTTPClient.shared.postAPIData(requestUrl: otpURLVerify,
                                          requestBody: otpAPIPostBody,
                                          resultType: OTPAPIResponse.self) { result in
                completionHandler(result)
            }
        } catch let error {
            debugPrint("error = \(error.localizedDescription)")
        }
    }
}
