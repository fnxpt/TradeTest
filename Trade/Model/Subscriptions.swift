class Subscriptions: Codable {
    
    let subscribeTo: [String]
    let unsubscribeFrom: [String]
    
    init(subscribed: [Product], removed: [Product] = []) {
        
        subscribeTo = subscribed.map { "trading.product.\($0.securityId)" }
        unsubscribeFrom = removed.map { "trading.product.\($0.securityId)" }
    }
}
