import XCTest
@testable import Trade

class SubscriptionsTest: XCTestCase {

    let product = Product(identifier: "sb26513", symbol: "APPL", displayName: "Apple",
                          closingPrice: Price(amount: 10, currency: "EUR"))
    let product2 = Product(identifier: "sb26500", symbol: "GOLD", displayName: "Gold",
                           closingPrice: Price(amount: 10, currency: "EUR"))
    let product3 = Product(identifier: "test", symbol: "Test", displayName: "Test",
                           closingPrice: Price(amount: 10, currency: "EUR"))
    
    func testInitialization() {
        
        let subscriptions = Subscriptions(subscribed: [product, product2], removed: [product3])
        
        XCTAssertEqual(subscriptions.subscribeTo.count, 2)
        XCTAssertEqual(subscriptions.unsubscribeFrom.count, 1)

        XCTAssertEqual(subscriptions.subscribeTo[0], "trading.product.sb26513")
        XCTAssertEqual(subscriptions.subscribeTo[1], "trading.product.sb26500")
        
        XCTAssertEqual(subscriptions.unsubscribeFrom[0], "trading.product.test")
    }
            
    func testInitializationWithoutSubscribing() {
        
        let subscriptions = Subscriptions(subscribed: [], removed: [product3])
        
        XCTAssertEqual(subscriptions.subscribeTo.count, 0)
        XCTAssertEqual(subscriptions.unsubscribeFrom.count, 1)
    }
    
    func testInitializationWithoutUnSubscribing() {
        
        let subscriptions = Subscriptions(subscribed: [product], removed: [])
        
        XCTAssertEqual(subscriptions.subscribeTo.count, 1)
        XCTAssertEqual(subscriptions.unsubscribeFrom.count, 0)
    }
    
    func testInitializationWithoutAnyValue() {
        
        let subscriptions = Subscriptions(subscribed: [], removed: [])
        
        XCTAssertEqual(subscriptions.subscribeTo.count, 0)
        XCTAssertEqual(subscriptions.unsubscribeFrom.count, 0)
    }
}
