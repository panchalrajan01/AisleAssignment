import Foundation

struct OTPApiRequest: Encodable {
    var number: String
    var otp: String
}
