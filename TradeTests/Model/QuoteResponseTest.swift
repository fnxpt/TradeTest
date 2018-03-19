import XCTest
@testable import Trade

class QuoteResponseTest: XCTestCase {
    
    func testInitialization() {
    
        let response = QuoteResponse(identifier: "sb26513", amount: 10)
        
        XCTAssertEqual(response.identifier, "sb26513")
        XCTAssertEqual(response.amount, 10)
    }
    
    func testInitializationWithEmptyDictionary() {
        
        let response = QuoteResponse(json: [:])
        
        XCTAssertNil(response)
    }
    
    func testInitializationWithInvalidDictionary() {
        
        let response = QuoteResponse(json: ["securityId": "sb26513"])
        
        XCTAssertNil(response)
    }
    
    func testInitializationWithValidDictionary() {
        
        let response = QuoteResponse(json: ["securityId": "sb26513",
                                            "currentPrice": "10692.3"])
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response!.identifier, "sb26513")
        XCTAssertEqual(response!.amount, 10692.3)
    }
}
