import XCTest
@testable import Trade

class ConnectedResponseTest: XCTestCase {
    
    func testInitialization() {
        
        let response = ConnectedResponse(sessionId: "8dfe4904-c578-4062-8e7d-8296896fbc28",
                                         date: Date(timeIntervalSince1970: 1521475160344))
        
        XCTAssertEqual(response.sessionId, "8dfe4904-c578-4062-8e7d-8296896fbc28")
        XCTAssertEqual(response.date, Date(timeIntervalSince1970: 1521475160344))
    }
    
    func testInitializationWithEmptyDictionary() {
        
        let response = ConnectedResponse(json: [:])
        
        XCTAssertNil(response)
    }
    
    func testInitializationWithInvalidDictionary() {
        
        let response = ConnectedResponse(json: ["time": 1521475160344])
        
        XCTAssertNil(response)
    }
    
    func testInitializationWithValidDictionary() {
        
        let response = ConnectedResponse(json: ["sessionId": "8dfe4904-c578-4062-8e7d-8296896fbc28",
                                                "time": 1521475160344])
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response!.sessionId, "8dfe4904-c578-4062-8e7d-8296896fbc28")
        XCTAssertEqual(response!.date, Date(timeIntervalSince1970: 1521475160344))
    }
}
