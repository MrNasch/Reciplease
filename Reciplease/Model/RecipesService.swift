//
//  RecipesService.swift
//  Reciplease
//
//  Created by Nasch on 23/05/2019.
//  Copyright © 2019 Nasch. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRequest {
    func request<Model: Codable>(_ url: String, completion: @escaping (Model?, Error?) -> Void)
}

struct AlamofireNetworkRequest: NetworkRequest {
    func request<Model: Codable>(_ url: String, completion: @escaping (Model?, Error?) -> Void) {
        AF.request(url).responseDecodable { (response: DataResponse<Model>) in
            if case .failure(let error) = response.result {
                // Dans le cas d'erreur
                return completion(nil, error)
            }
            
            let statusCode = response.response?.statusCode
            
            if statusCode == 401 {
                return completion(nil, NSError())
            }
            guard case .success(let result) = response.result else {
                //Erreur improbable
                return
            }
            completion(result, nil)
            
        }
    }
}

struct FakeNetworkRequest: NetworkRequest {
    
    var data: Data?
    var error: Error?
    var statusCode: Int?
    
    func request<Model: Codable>(_ url: String, completion: @escaping (Model?, Error?) -> Void) {
        
        if let error = error {
            // Dans le cas d'erreur
            return completion(nil, error)
        }
            
        if statusCode == 401 {
            return completion(nil, NSError())
        }
        
        guard let data = data else { return }
        
        do {
            let decoded = try JSONDecoder().decode(Model.self, from: data)
            completion(decoded, nil)
        } catch {
            completion(nil, error)
        }
    }
}

class NewRecipeService {
    let apiKey = valueForAPIKey(named: "ApiKey")
    let apiId = valueForAPIKey(named: "ApiId")
    var networkRequest: NetworkRequest = AlamofireNetworkRequest()
    
    func getRecipes(query: String, completion: @escaping (Recipes?, Error?) -> Void) {
        let url = "https://api.edamam.com/search?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&app_id=\(apiId)&app_key=\(apiKey)"
        networkRequest.request(url) { (recipes: Recipes?, error: Error?) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(recipes, nil)
            }

        }
    }
}


