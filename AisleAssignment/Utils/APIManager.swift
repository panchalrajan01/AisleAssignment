import Foundation

enum APIEndpoint {
    case phoneNumberLogin
    case otpVerify
    case notesList

    var path: String {
        switch self {
        case .phoneNumberLogin:
            return "/users/phone_number_login"
        case .otpVerify:
            return "/users/verify_otp"
        case .notesList:
            return "/users/test_profile_list"
        }
    }
}

final class APIManager {
    static let shared = APIManager()
    
    private let baseURL = "https://app.aisle.co/V1"

    func getAPIURL(endpoint: APIEndpoint) -> String {
        return baseURL + endpoint.path
    }

    private init() {}
}
