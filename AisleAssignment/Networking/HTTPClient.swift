import Foundation

final class HTTPClient {
    
    static let shared = HTTPClient()
    private init() {}

    func getAPIData<T:Decodable>(requestUrl: URL,
                                 resultType: T.Type,
                                 completionHandler: @escaping(_ result: T?) -> Void) {
        URLSession.shared.dataTask(with: requestUrl) {data, response, error in
            if(error == nil && data != nil && data?.count != 0) {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data!)
                    _ = completionHandler(result)
                } catch let error {
                    debugPrint("error = \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    func postAPIData<T:Decodable>(requestUrl: URL,
                                  requestBody: Data,
                                  resultType: T.Type,
                                  completionHandler: @escaping(_ result: T) -> Void) {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "post"
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if (data != nil && data?.count != 0) {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data!)
                    _ = completionHandler(result)
                } catch let error {
                    debugPrint("error = \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func getAPIDataWithHeader<T:Decodable>(requestUrl: URL,
                                           requestHeader: String,
                                           resultType: T.Type,
                                           completionHandler: @escaping(_ result: T?) -> Void) {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(requestHeader, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            if(error == nil && data != nil && data?.count != 0) {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data!)
                    _ = completionHandler(result)
                } catch let error {
                    debugPrint("error = \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
