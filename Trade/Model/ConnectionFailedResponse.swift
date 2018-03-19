class ConnectionFailedResponse: Codable, FailedReasonProtocol, SocketResponseObject {
    
    let errorCode: String
    let developerMessage: String
    let message: String
    
    init(code: String, message: String, developerMessage: String) {
        
        self.errorCode = code
        self.developerMessage = developerMessage
        self.message = message
    }
    
    required convenience init?(json: [String: Any]) {
        
        guard let errorCode = json["errorCode"] as? String,
            let developerMessage = json["developerMessage"] as? String,
            let message = json["message"] as? String else {
                
                return nil
        }
        
        self.init(code: errorCode, message: message, developerMessage: developerMessage)
    }
}
