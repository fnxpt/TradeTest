import XCTest
@testable import Trade

class PriceTest: XCTestCase {
    
    func testSimple() {
        
        let item = Price(amount: 20, currency: "EUR")
        
        XCTAssertEqual(item.amount, 20)
        XCTAssertEqual(item.currency, "EUR")
        XCTAssertEqual(item.decimals, 2)
    }
}
