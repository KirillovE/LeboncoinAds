import Foundation

/// Networking layer to load some data from server API
struct NetworkHandler {
    typealias GeneralResponse = (Result<Data, TextualError>) -> ()
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Loads data of type _application/json_ from server to memory
    /// - Parameters:
    ///   - url: Address to load from
    ///   - completion: Action to perform after loading ends
    /// - Returns: Suspended task object
    func loadDataFromURL(_ url: URL, completion: @escaping GeneralResponse) -> URLSessionDataTask {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                let responseError = TextualError(stringLiteral: error.localizedDescription)
                completion(.failure(responseError))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                let serverError = TextualError(description: response.debugDescription)
                completion(.failure(serverError))
                return
            }
            
            guard
                let mimeType = httpResponse.mimeType,
                mimeType == "application/json",
                let loadedData = data
            else {
                completion(.failure("Invalid response format"))
                return
            }
            
            completion(.success(loadedData))
        }
    }
}
