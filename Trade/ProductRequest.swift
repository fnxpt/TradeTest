import Foundation

class ProductRequest: RequestProtocol, Requestable {
    
    typealias ResponseType = Product
    
    static func get(identifier: String,
                    completionHandler: @escaping (Response<ResponseType>) -> Void) {
        
        let path = API.endpoint + String(format: API.product, identifier)
        
        if let url = URL(string: path) {
            
            self.request(path: url,
                         parameters: nil,
                         completionHandler: completionHandler)
        } else {
            completionHandler(Response.error(error: ServiceError.unexpected))
        }
    }
}
