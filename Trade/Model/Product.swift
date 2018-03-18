import Foundation

class Product: Codable {
    
    var symbol: String
    var securityId: String
    var displayName: String
    
    var closingPrice: Price
    var currentPrice: Price
    
    init(identifier: String, symbol: String, displayName: String, closingPrice: Price, currentPrice: Price? = nil) {
        
        self.securityId = identifier
        self.symbol = symbol
        self.displayName = displayName
        self.closingPrice = closingPrice
        self.currentPrice = currentPrice ?? closingPrice
    }
}

extension Product {
    
    var isWinning: Bool {
        return currentPrice.amount >= closingPrice.amount
    }
    
    var percentage: Double {
        return (currentPrice.amount - closingPrice.amount) / closingPrice.amount * 100
    }
}

extension Product: Equatable {
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.securityId == rhs.securityId
    }
}

extension Product: Updatable {
    
    typealias UpdateType = Double
    
    func update(model: UpdateType) {
        
        currentPrice.amount = model
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notification_\(securityId)"), object: self)
    }
}
