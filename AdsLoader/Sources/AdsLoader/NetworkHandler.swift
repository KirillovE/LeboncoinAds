import Foundation
import Models

/// Networking layer to load some data from server API
struct NetworkHandler {
    typealias GeneralResponse = (Result<Data, TextualError>) -> ()
    
    private let session: URLSession
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
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
                let serverError = TextualError(stringLiteral: response.debugDescription)
                completion(.failure(serverError))
                return
            }
            
            guard
                let mimeType = httpResponse.mimeType,
                mimeType == "text/plain",
                let loadedData = data
            else {
                completion(.failure("Invalid response format"))
                return
            }
            
            completion(.success(loadedData))
        }
    }
    
    /// Decode provided data with strongly-typed error
    /// - Parameters:
    ///   - type: The type of the value to decode from the supplied JSON objec
    ///   - data: The JSON object to decode
    /// - Returns: Decoding `Result`
    func decode<T: Decodable>(_ type: T.Type, from data: Data) -> Result<T, TextualError> {
        do {
            let decoded = try decoder.decode(type, from: data)
            return .success(decoded)
        } catch {
            let decodingError = TextualError(stringLiteral: error.localizedDescription)
            return .failure(decodingError)
        }
    }
}
