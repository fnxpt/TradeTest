import Foundation

class SocketResponse {
    
    let body: SocketResponseObject?
    let type: SocketResponseType
    
    init?(data: Data) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let typeString = json?["t"] as? String,
            let type = SocketResponseType(rawValue: typeString),
            let body = json?["body"] as? [String: Any] else {
                
                return nil
        }
        
        self.type = type
        self.body = type.object().init(json: body)
    }
}
