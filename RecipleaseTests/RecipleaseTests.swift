//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Nasch on 25/04/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import XCTest

@testable import Reciplease

class RecipleaseTests: XCTestCase {
    
    func testGivenGetRecipes_WhenGetNoData_ThenError() {
        //Given
        let recipeServices = NewRecipeService()
        recipeServices.networkRequest = FakeNetworkRequest(data: nil, error: FakeResponseData.error, statusCode: 500)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        recipeServices.getRecipes(query: "chicken") { (recipe, error) in
            //then
            XCTAssertNil(recipe)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenGetRecipes_WhenGetData5TimesIn1Min_ThenError() {
        //Given
        let recipeServices = NewRecipeService()
        recipeServices.networkRequest = FakeNetworkRequest(data: nil, error: nil, statusCode: 401)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        recipeServices.getRecipes(query: "chicken") { (recipe, error) in
            //then
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // 401, 200, incorectData
    
}
