//
//  ShoppingAppApiClientTests.swift
//  ShoppingAppTests
//
//  Created by isa on 2.03.2023.
//

import XCTest
@testable import ShoppingApp

class ShoppingAppApiClientTests: XCTestCase {
    var networkService: NetworkService!
    let baseUrl = URL(string: "https://mocki.io/v1/")
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
        
    func testNotNillService() {
        XCTAssertNotNil(networkService)
    }
    
    func testApiUrlAssertEqual() {
        XCTAssertNotNil(NetworkConstants.baseUrl)
        XCTAssertEqual(URL(string: NetworkConstants.baseUrl), baseUrl)
    }
                
    func testSuccessProductsByUsingService() {
        XCTAssertNotNil(networkService)
        let expectationReceive = XCTestExpectation(description: TextConstants.success)
        let expectationFailure = XCTestExpectation(description: TextConstants.errorParsingTitle)
        expectationFailure.isInverted = true
        networkService.request(to: DashboardRouter.allProductsURL, completion: NetworkHandler().networkResult(completion: { (result: Result<[ProductModel], Error>) in
            switch result {
            case .success(let items):
                XCTAssertNotNil(items)
                XCTAssertGreaterThan(items.count, 0)
                XCTAssertNotNil(items.first?.productName)
                expectationReceive.fulfill()
            case .failure:
                expectationFailure.fulfill()
            }
        }))?.resume()
        wait(for: [expectationReceive, expectationFailure], timeout: 5)
    }            
}
