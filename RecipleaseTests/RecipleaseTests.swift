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
    func testGivenGetRecipes_WhenGetFailed_ThenError() {
    //Given
        let recipeService = FakeNetworkRequest(data: nil, error: FakeResponseData.error, statusCode: nil)
    //When
        
    //Then
    }

    
    

    
    
}
