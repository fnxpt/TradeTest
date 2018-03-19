import XCTest
@testable import Trade

class ProductRequestTest: XCTestCase {
    
    func testWithValidProduct() {
        
        let expectation = self.expectation(description: "Wait for request")
        ProductRequest.get(identifier: "sb26513") { response in
            
            if case Response.success(let object) = response {
                XCTAssert(object is Product)
            } else {
                XCTFail("Unexpected response")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 60)
    }
    
    func testWithInValidProduct() {
        
        let expectation = self.expectation(description: "Wait for request")
        ProductRequest.get(identifier: "test") { response in
            
            if case Response.error(let error) = response {
                XCTAssert(error is ServiceError)
                
                if case ServiceError.unexpected = error {
                } else {
                    XCTFail("Unexpected error")
                }
            } else {
                XCTFail("Unexpected response")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 60)
    }
}
