class FailedResponse: Codable, FailedReasonProtocol, SocketResponseObject {
    
    let errorCode: String
    let developerMessage: String
    let message: String
    
    init(code: String, developerMessage: String, message: String? = nil) {
        
        self.errorCode = code
        self.developerMessage = developerMessage
        self.message = message ?? developerMessage
    }
    
    required convenience init?(json: [String: Any]) {
        
        guard let errorCode = json["errorCode"] as? String,
            let developerMessage = json["developerMessage"] as? String else {
                
                return nil
        }
        
        let message = json["message"] as? String
        
        self.init(code: errorCode, developerMessage: developerMessage, message: message)
    }
}
