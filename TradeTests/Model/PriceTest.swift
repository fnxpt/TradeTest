import XCTest
@testable import Trade

class PriceTest: XCTestCase {
    
    let defaultLocale = Locale(identifier: "en_US")
    
    func testSimple() {
        
        let item = Price(amount: 20, currency: "EUR", locale: defaultLocale)
        
        XCTAssertEqual(item.amount, 20)
        XCTAssertEqual(item.description, "€20.00")
        
    }
    
    func testSimple2() {
        
        let item = Price(amount: 19.999999999, currency: "USD", locale: defaultLocale)
        
        XCTAssertEqual(item.amount, 19.999999999)
        XCTAssertEqual(item.description, "$20.00")
        
    }
    
    func testSimple3() {
        
        let item = Price(amount: 19.969999999, currency: "JPY", locale: defaultLocale)
        
        XCTAssertEqual(item.amount, 19.969999999)
        XCTAssertEqual(item.description, "¥19.97")
        
    }
    
    func testSimple4() {
        
        let item = Price(amount: 5.123123, currency: "EUR", decimals: 0, locale: defaultLocale)
        
        XCTAssertEqual(item.amount, 5.123123)
        XCTAssertEqual(item.description, "€5")
    }
    
    func testSimple5() {
        
        let item = Price(amount: 5.123123, currency: "EUR", decimals: 3, locale: defaultLocale)
        
        XCTAssertEqual(item.amount, 5.123123)
        XCTAssertEqual(item.description, "€5.123")
    }
    
    func testSimple6() {
        
        let item = Price(amount: 20.356, currency: "EUR", locale: Locale(identifier: "nl_NL"))

        XCTAssertEqual(item.description, "€ 20,36")
    }
    
    func testSimple7() {
        
        let item = Price(amount: 20.356, currency: "JPY", locale: Locale(identifier: "jp_JP"))

        XCTAssertEqual(item.description, "¥ 20.36")
    }
}
