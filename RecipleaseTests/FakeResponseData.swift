//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Nasch on 06/06/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation

class FakeResponseData {
    let responseOK = HTTPURLResponse(url: URL(string: "https://test.be")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    let responseKO = HTTPURLResponse(url: URL(string: "https://test.be")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class RecipesError: Error {}
    let error = RecipesError()
    
    
    var recipesCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    // Error data
    let recipesIncorrectData = "error".data(using: .utf8)!
    let imageData = "image".data(using: .utf8)!
}

