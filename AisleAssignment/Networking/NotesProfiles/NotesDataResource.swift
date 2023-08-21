import Foundation

struct NotesDataResource {

    func getNotesData(token: String,
                      completionHandler: @escaping (_ results: NotesAPIResponse?) -> Void) {
        let notesAPIEndPoint = APIManager.shared.getAPIURL(endpoint: .notesList)
        guard let notesAPIEndPointURL = URL(string: notesAPIEndPoint) else {
            AlertManager.shared.showAlert(title: "Internal Error", message: "Please Contact Support Team")
            return
        }
        HTTPClient.shared.getAPIDataWithHeader(requestUrl: notesAPIEndPointURL,
                                               requestHeader: token,
                                               resultType: NotesAPIResponse.self) { result in
            completionHandler(result)
        }
    }
}
