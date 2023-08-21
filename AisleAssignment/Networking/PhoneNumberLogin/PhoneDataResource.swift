import Foundation

struct PhoneDataResource {
    
    func postPhoneNumber(phoneRequest: PhoneAPIRequest,
                         completionHandler: @escaping (_ result: PhoneAPIResponse?) -> Void) {
        let phoneAPIEndPoint = APIManager.shared.getAPIURL(endpoint: .phoneNumberLogin)
        guard let phoneAPIEndPointURL = URL(string: phoneAPIEndPoint) else {
            AlertManager.shared.showAlert(title: "Internal Error", message: "Please Contact Support Team")
            return
        }
        do {
            let phoneApiPostBody = try JSONEncoder().encode(phoneRequest)
            HTTPClient.shared.postAPIData(requestUrl: phoneAPIEndPointURL,
                                          requestBody: phoneApiPostBody,
                                          resultType: PhoneAPIResponse.self) { result in
                completionHandler(result)
            }
        } catch let error {
            debugPrint("error = \(error.localizedDescription)")
        }
    }
}
