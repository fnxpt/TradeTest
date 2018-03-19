import XCTest
@testable import Trade

class SocketResponseTest: XCTestCase {
    
    func testInitialization() {
        let response = SocketResponse(type: .connected, body: nil)
        
        XCTAssertEqual(response.type, .connected)
        XCTAssertNil(response.body)
    }
    
    func testInitializationWithObject() {
        
        let quote = QuoteResponse(identifier: "sb26513", amount: 10)
        let response = SocketResponse(type: .quote,
                                      body: quote)
        
        XCTAssertEqual(response.type, .quote)
        XCTAssertNotNil(response.body)
        XCTAssert(response.body is QuoteResponse)
    }
    
    func testJSONInitializationWithTypeSuccess() {
        
        let json: [String: Any] = ["t": "connect.connected",
                                   "body": [
                                    "sessionId": "8dfe4904-c578-4062-8e7d-8296896fbc28",
                                    "time": 1521475160344
            ]]
        
        let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        if let data = data {
            let response = SocketResponse(data: data)
            
            XCTAssertNotNil(response)
            
            XCTAssertEqual(response!.type, .connected)
            XCTAssertNotNil(response!.body)
            XCTAssert(response!.body! is ConnectedResponse)
            
        } else {
            XCTFail("Unable to parse json")
        }
    }
    
    func testJSONInitializationWithTypeSuccessdAndIncompleteData() {
        
        let json: [String: Any] = ["t": "connect.connected",
                                   "body": [
                                    "time": 1521475160344
            ]]
        
        let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        if let data = data {
            let response = SocketResponse(data: data)
            
            XCTAssertNotNil(response)
            
            XCTAssertEqual(response!.type, .connected)
            XCTAssertNil(response!.body)
            
        } else {
            XCTFail("Unable to parse json")
        }
    }
    
    func testJSONInitializationWithTypeFailed() {
        
        let json: [String: Any] = ["t": "connect.failed",
                    "body": [
                        "developerMessage": "Missing JWT Access Token in request",
                        "errorCode": "RTF_002"
            ]]
        
        let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        if let data = data {
            let response = SocketResponse(data: data)
            
            XCTAssertNotNil(response)
            
            XCTAssertEqual(response!.type, .failed)
            XCTAssertNotNil(response!.body)
            XCTAssert(response!.body! is FailedResponse)
            
        } else {
            XCTFail("Unable to parse json")
        }
    }
    
    func testJSONInitializationWithTypeFailedAndIncompleteData() {
        
        let json: [String: Any] = ["t": "connect.failed",
                                   "body": [
                                    "developerMessage": "Missing JWT Access Token in request"
            ]]
        
        let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        if let data = data {
            let response = SocketResponse(data: data)
            
            XCTAssertNotNil(response)
            
            XCTAssertEqual(response!.type, .failed)
            XCTAssertNil(response!.body)
            
        } else {
            XCTFail("Unable to parse json")
        }
    }
    
    func testJSONInitializationWithTypeQuote() {
        
        let json: [String: Any] = ["t": "trading.quote",
                                   "body": [
                                    "securityId": "sb26513",
                                    "currentPrice": "10692.3"
            ]]
        
        let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        if let data = data {
            let response = SocketResponse(data: data)
            
            XCTAssertNotNil(response)
            
            XCTAssertEqual(response!.type, .quote)
            XCTAssertNotNil(response!.body)
            XCTAssert(response!.body! is QuoteResponse)
            
        } else {
            XCTFail("Unable to parse json")
        }
    }
    
    func testJSONInitializationWithTypeQuoteAndIncompleteData() {
        
        let json: [String: Any] = ["t": "trading.quote",
                                   "body": [
                                    "securityId": "sb26513"
            ]]
        
        let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        if let data = data {
            let response = SocketResponse(data: data)
            
            XCTAssertNotNil(response)
            
            XCTAssertEqual(response!.type, .quote)
            XCTAssertNil(response!.body)
            
        } else {
            XCTFail("Unable to parse json")
        }
    }
    
    func testJSONInitializationWithInvalidJSON() {
        let json: [String: Any] = [:]
        
        let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        if let data = data {
            let response = SocketResponse(data: data)
            
            XCTAssertNil(response)

        } else {
            
            XCTFail("Unable to parse json")
        }
    }
}
