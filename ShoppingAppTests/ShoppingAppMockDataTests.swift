//
//  ShoppingAppMockDataTests.swift
//  ShoppingAppTests
//
//  Created by isa on 3.03.2023.
//

import XCTest
@testable import ShoppingApp

class ShoppingAppMockDataTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    private func getProductData() -> Data {
        return """
            {
            "productName": "La Lorraine Tombul Ekmek",
            "productDescription": "Doğal ham maddelerden üretilir.Koruyucu ve katkı maddesi içermez.İçindekiler: Un, su, maya, tuz",
            "productPrice": 7.5,
            "productImage": "https://github.com/android-getir/public-files/blob/main/images/5f36a28b29d3b131b9d95548_tr_1637858193743.jpeg"
            }
            """.data(using: .utf8)!
    }
    
    private func getProductInvalidData() -> Data {
        return """
            {
            "productName": "La Lorraine Tombul Ekmek",
            "productDescription": "Doğal ham maddelerden üretilir.Koruyucu ve katkı maddesi içermez.İçindekiler: Un, su, maya, tuz",
            "productPrice": "7.5",
            "productImage": "https://github.com/android-getir/public-files/blob/main/images/5f36a28b29d3b131b9d95548_tr_1637858193743.jpeg"
            }
            """.data(using: .utf8)!
    }
  
    func testValidProductData() {
        var validProduct: ProductModel
        let expectationReceive = XCTestExpectation(description: TextConstants.success)
        let expectationFailure = XCTestExpectation(description: TextConstants.errorParsingTitle)
        expectationFailure.isInverted = true
        do {
            let response = try JSONDecoder().decode(ProductModel.self, from: getProductData())
            validProduct = response
            XCTAssertEqual(validProduct.productName, "La Lorraine Tombul Ekmek")
            XCTAssertNotNil(validProduct)
            XCTAssertNil(validProduct.qty)
            expectationReceive.fulfill()
        } catch {
            expectationFailure.fulfill()
        }
        wait(for: [expectationReceive, expectationFailure], timeout: 5)
    }
    
    func testInvalidProductData() {
        var validProduct: ProductModel
        let expectationReceive = XCTestExpectation(description: TextConstants.success)
        let expectationFailure = XCTestExpectation(description: TextConstants.errorParsingTitle)
        expectationFailure.isInverted = true
        do {
            let response = try JSONDecoder().decode(ProductModel.self, from: getProductInvalidData())
            validProduct = response
            XCTAssertEqual(validProduct.productName, "La Lorraine Tombul Ekmek")
            expectationFailure.fulfill()
        } catch {
            expectationReceive.fulfill()
        }
        wait(for: [expectationReceive, expectationFailure], timeout: 5)
    }
    
    func testProductsFromMockData() {
        var items: [ProductModel] = []
        let expectationReceive = XCTestExpectation(description: TextConstants.success)
        let expectationFailure = XCTestExpectation(description: TextConstants.errorParsingTitle)
        expectationFailure.isInverted = true
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "UnitTestDataItems", ofType: "json") else {
            expectationFailure.fulfill()
            fatalError("UnitTestDataItems.json not found")
        }
        
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            expectationFailure.fulfill()
            fatalError("Unable to convert UnitTestData.json to String")
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            expectationFailure.fulfill()
            fatalError("Unable to convert UnitTestData.json to Data")
        }
        
        do {
            let response = try JSONDecoder().decode([ProductModel].self, from: jsonData)
            items = response
            XCTAssertNotNil(items)
            XCTAssertGreaterThan(items.count, 0)
            XCTAssertNotNil(items.first?.productName)
            expectationReceive.fulfill()
        } catch {
            expectationFailure.fulfill()
        }
        wait(for: [expectationReceive, expectationFailure], timeout: 5)
        items = []
        XCTAssertTrue(items.isEmpty)
    }
}
