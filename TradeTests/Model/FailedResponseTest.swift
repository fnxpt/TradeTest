import XCTest
@testable import Trade

class FailedResponseTest: XCTestCase {
        
        func testInitialization() {
            
            let response = FailedResponse(code: "RTF_002", developerMessage: "Missing JWT Access Token in request")
            
            XCTAssertEqual(response.errorCode, "RTF_002")
            XCTAssertEqual(response.developerMessage, "Missing JWT Access Token in request")
            XCTAssertEqual(response.message, "Missing JWT Access Token in request")
        }
    
    func testInitializationWithMessage() {
        
        let response = FailedResponse(code: "RTF_002",
                                      developerMessage: "Missing JWT Access Token in request",
                                      message: "Unable to login")
        
        XCTAssertEqual(response.errorCode, "RTF_002")
        XCTAssertEqual(response.developerMessage, "Missing JWT Access Token in request")
        XCTAssertEqual(response.message, "Unable to login")
    }
        
        func testInitializationWithEmptyDictionary() {
            
            let response = FailedResponse(json: [:])
            
            XCTAssertNil(response)
        }
        
        func testInitializationWithInvalidDictionary() {
            
            let response = FailedResponse(json: ["errorCode": "RTF_002"])
            
            XCTAssertNil(response)
        }
        
        func testInitializationWithValidDictionary() {
            
            let response = FailedResponse(json: ["developerMessage": "Missing JWT Access Token in request",
                                                 "errorCode": "RTF_002"])
            
            XCTAssertNotNil(response)
            XCTAssertEqual(response!.errorCode, "RTF_002")
            XCTAssertEqual(response!.developerMessage, "Missing JWT Access Token in request")
        }
}
