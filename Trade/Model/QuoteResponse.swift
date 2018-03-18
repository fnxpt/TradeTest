import Foundation

class QuoteResponse: SocketResponseObject {
    
    let identifier: String
    let amount: Double
    let date: Date
    
    required init?(json: [String: Any]) {
        
        guard let identifier = json["securityId"] as? String,
            let priceString = json["currentPrice"] as? String,
            let amount = Double(priceString),
            let timestamp = json["timeStamp"] as? Double else {
                
                return nil
        }
        
        self.identifier = identifier
        self.amount = amount
        self.date = Date(timeIntervalSince1970: timestamp)
    }
}
