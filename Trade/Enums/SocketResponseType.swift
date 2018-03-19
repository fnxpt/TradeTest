enum SocketResponseType: String {
    
    case connected = "connect.connected"
    case quote = "trading.quote"
    case failed = "connect.failed"
    
    func object() -> SocketResponseObject.Type {
        switch self {
        case .quote:
            return QuoteResponse.self
        case .failed:
            return FailedResponse.self
        case .connected:
            return ConnectedResponse.self
        }
    }
}
