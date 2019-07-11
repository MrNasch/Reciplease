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

        //USE NEWRECIPESERVICE CHANGE NETWORK TO FAKENETWORK
        //When
        let fakeResponse = FakeNetworkRequest(data: nil, error: FakeResponseData.error, statusCode: 500)
        
        fakeResponse.request("chicken") { ( recipe: Recipe? , error: Error?) in
            //Then
            XCTAssertNil(recipe)
            XCTAssertNotNil(error)
            XCTAssertEqual(recipe?.label, nil)
        }
    }
    
    func testGivenGetRecipes_WhenGetData_ThenNoError() {
        //Given
        
        //USE NEWRECIPESERVICE CHANGE NETWORK TO FAKENETWORK
        //When
        let fakeResponse = FakeNetworkRequest(data: FakeResponseData.recipesCorrectData, error: nil, statusCode: 200)
        
        fakeResponse.request("chicken") { ( recipe: Recipe? , error: Error?) in
            //Then
            XCTAssertNotNil(recipe)
            XCTAssertNil(error)
            XCTAssertEqual(recipe?.label, "Chicken Vesuvio")
        }
    }
}
