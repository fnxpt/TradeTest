import XCTest
@testable import Trade

class ProductTest: XCTestCase {
    
    let defaultLocale = Locale(identifier: "en_US")
    
    func testInitialization() {
        
        let price = Price(amount: 10, currency: "EUR", locale: defaultLocale)
        let item = Product(identifier: "26608", symbol: "FRANCE40", displayName: "French Exchange", closingPrice: price)
        
        XCTAssertEqual(item.securityId, "26608")
        XCTAssertEqual(item.symbol, "FRANCE40")
        XCTAssertEqual(item.displayName, "French Exchange")
        XCTAssertEqual(item.closingPrice.description, "€10.00")
        XCTAssertEqual(item.currentPrice.description, "€10.00")
    }
    
    func testIntitializationWithCurrentPrice() {
        
        let price = Price(amount: 10, currency: "EUR", locale: defaultLocale)
        let updatedPrice = Price(amount: 20, currency: "EUR", locale: defaultLocale)
        let item = Product(identifier: "26608", symbol: "FRANCE40", displayName: "French Exchange",
                           closingPrice: price, currentPrice: updatedPrice)
        
        XCTAssertEqual(item.closingPrice.description, "€10.00")
        XCTAssertEqual(item.currentPrice.description, "€20.00")
    }
    
    func testPriceUpdate() {
        
        let price = Price(amount: 10, currency: "EUR", locale: defaultLocale)
        let item = Product(identifier: "26608", symbol: "FRANCE40", displayName: "French Exchange", closingPrice: price)
        
        XCTAssertEqual(item.closingPrice.description, "€10.00")
        XCTAssertEqual(item.currentPrice.description, "€10.00")
        
        item.update(model: 20)
        
        XCTAssertEqual(item.closingPrice.description, "€10.00")
        XCTAssertEqual(item.currentPrice.description, "€20.00")
    }
    
    func testPricePercentageAndWinning() {
        
        let price = Price(amount: 10, currency: "EUR", locale: defaultLocale)
        let item = Product(identifier: "26608", symbol: "FRANCE40", displayName: "French Exchange", closingPrice: price)
        
        XCTAssertEqual(item.isWinning, true)
        XCTAssertEqual(item.percentage, 0)
        
        item.update(model: 20)
        
        XCTAssertEqual(item.isWinning, true)
        XCTAssertEqual(item.percentage, 100)
        
        item.update(model: 5)
        
        XCTAssertEqual(item.isWinning, false)
        XCTAssertEqual(item.percentage, -50)
        
    }
}
