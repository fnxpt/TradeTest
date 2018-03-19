import Foundation

class SocketResponse {
    
    let body: SocketResponseObject?
    let type: SocketResponseType
    
    init(type: SocketResponseType, body: SocketResponseObject?) {
        
        self.type = type
        self.body = body
    }
    
    convenience init?(data: Data) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let typeString = json?["t"] as? String,
            let type = SocketResponseType(rawValue: typeString),
            let body = json?["body"] as? [String: Any] else {
                
                return nil
        }
        
        let response = type.object().init(json: body)
        
        self.init(type: type, body: response)
    }
}
