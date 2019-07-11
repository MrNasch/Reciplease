//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Nasch on 06/06/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://test.be")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://test.be")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class RecipesError: Error {}
    static let error = RecipesError()
    
    
    static var recipesCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    // Error data
    static let recipesIncorrectData = "error".data(using: .utf8)!
    static let imageData = "image".data(using: .utf8)!
}

