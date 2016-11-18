//
//  Vapor_Demo_AppTests.swift
//  Vapor Demo AppTests
//
//  Created by Timothy Barraclough on 17/11/16.
//
//

import XCTest
@testable import Vapor_Demo_App

class Vapor_Demo_AppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLocationEndpointReturnsLocation() {
        
        var location : Location?
        let asyncExpectation = expectation(description: "Server returned one item for API Endpoint")
        do {
        try Location.requestSingleLocation(1) {
            location = $0
            asyncExpectation.fulfill()
            
        }
        } catch {
            XCTFail()
        }
        waitForExpectations(timeout: 5) { _ in
            if let _ = location {
                XCTAssertNotNil(location)
            } else {
                XCTFail()
            }
            
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
