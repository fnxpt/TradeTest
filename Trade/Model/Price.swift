import Foundation

struct Price: Codable {
    
    var formatter: NumberFormatter
    var amount: Double
    private let currency: String
    private let decimals: Int
    private let locale: Locale
    
    private enum CodingKeys: String, CodingKey {
        case amount
        case currency
        case decimals
    }
    
    init(amount: Double,
         currency: String,
         decimals: Int = 2,
         locale: Locale = .current) {

        self.amount = amount
        self.currency = currency
        self.decimals = decimals
        self.locale = locale
        
        formatter = NumberFormatter()
        
        formatter.locale = self.locale
        formatter.numberStyle = .currency
        formatter.currencyCode = self.currency
        formatter.minimumFractionDigits = self.decimals
        formatter.maximumFractionDigits = self.decimals
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let amount = try container.decode(String.self, forKey: .amount)
        let currency = try container.decode(String.self, forKey: .currency)
        let decimals = try container.decode(Int.self, forKey: .decimals)
        
        self.init(amount: Double(amount) ?? 0, currency: currency, decimals: decimals)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(String("\(amount)"), forKey: .amount)
        try container.encode(currency, forKey: .currency)
        try container.encode(decimals, forKey: .decimals)
    }
}

extension Price: CustomStringConvertible {
    
    var description: String {
        return formatter.string(for: amount) ?? ""    
    }
}
