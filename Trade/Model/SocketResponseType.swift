enum SocketResponseType: String {
    
    case quote = "trading.quote"
    case failed = "connect.failed"
    
    func object() -> SocketResponseObject.Type {
        switch self {
        case .quote:
            return QuoteResponse.self
        case .failed:
            return ConnectionFailedResponse.self
        }
    }
}
