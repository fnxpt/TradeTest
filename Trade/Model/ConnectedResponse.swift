import Foundation

class ConnectedResponse: Codable, SocketResponseObject {
    
    let sessionId: String
    let date: Date
    
    init(sessionId: String, date: Date) {
        
        self.sessionId = sessionId
        self.date = date
    }
    
    required convenience init?(json: [String: Any]) {
        
        guard let sessionId = json["sessionId"] as? String,
            let timestamp = json["time"] as? Int else {
                
                return nil
        }
        
        self.init(sessionId: sessionId, date: Date(timeIntervalSince1970: Double(timestamp)))
    }
}
