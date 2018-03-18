import Foundation

protocol Requestable {
    
    static func request<T: Decodable>(path: URL,
                                      parameters: [String: String]?,
                                      completionHandler: @escaping (Response<T>) -> Void)
}

extension Requestable {
    
    internal static func request<T>(path: URL,
                                    parameters: [String : String]?,
                                    completionHandler: @escaping (Response<T>) -> Void) where T: Decodable {
        
        var request = URLRequest(url: path)
        request.allHTTPHeaderFields = ["Authorization": API.token,
                                       "Accept": "application/json",
                                       "Accept-Language": "nl-NL,en;q=0.8"
        ]
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                
                completionHandler(.error(error: error))
            } else if let data = data {
                
                do {
                    let object = try T.decode(data: data)
                    completionHandler(.success(object: object))
                } catch {

                    if data.isEmpty {
                        completionHandler(.error(error: ServiceError.unexpected))
                    } else if error is DecodingError,
                        let reason = try? ConnectionFailedResponse.decode(data: data) {
                        completionHandler(.error(error: ServiceError.failed(reason: reason)))
                    } else {
                        completionHandler(.error(error: error))
                    }
                }
            } else {
                
                completionHandler(.error(error: ServiceError.unexpected))
            }
        }
        
        task.resume()
        
    }
}
