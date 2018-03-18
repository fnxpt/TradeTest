class ConnectionFailedResponse: Codable, FailedReasonProtocol, SocketResponseObject {
    
    let errorCode: String
    let developerMessage: String
    let message: String
    
    required init?(json: [String: Any]) {
        
        guard let errorCode = json["errorCode"] as? String,
            let developerMessage = json["developerMessage"] as? String,
            let message = json["message"] as? String else {
                
                return nil
        }
        
        self.errorCode = errorCode
        self.developerMessage = developerMessage
        self.message = message
    }
}
