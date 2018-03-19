import Foundation

class QuoteResponse: SocketResponseObject {
    
    let identifier: String
    let amount: Double
    
    init(identifier: String, amount: Double) {
        
        self.identifier = identifier
        self.amount = amount
    }
    
    required convenience init?(json: [String: Any]) {
        
        guard let identifier = json["securityId"] as? String,
            let priceString = json["currentPrice"] as? String,
            let amount = Double(priceString) else {
                
                return nil
        }
        
        self.init(identifier: identifier, amount: amount)
    }
}
