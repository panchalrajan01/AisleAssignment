import UIKit

class ImageManager {

    static let shared = ImageManager()

    private init() {}

    func getImageFromURL(urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
        guard let requestURL = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: requestURL)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completionHandler(nil)
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completionHandler(nil)
                return
            }
            completionHandler(image)
        }.resume()
    }
}
