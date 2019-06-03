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
    var networkRequest: NetworkRequest = AlamofireNetworkRequest()
    
    func getRecipes(query: String) {
        let stringUrl = "test"
    
        networkRequest.request(stringUrl) { (<#(Decodable & Encodable)?#>, error) in
            return
        }
    }
}
// ancienne
class RecipesServices {
    //create func that get Recipe from edaman
    func getRecipes(query: String) {
        let stringUrl = "https://api.edamam.com/search?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&app_id=9c0ab54b&app_key=a537262bf1833c6d02064b2bbf05e1aa"
        // API KEY
        AF.request(stringUrl).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            let statusCode = response.response?.statusCode
            
            if case .failure(let error) = response.result {
                // Dans le cas d'erreur
            }
            
            guard case .success = response.result else {
                //Erreur improbable
                return
            }
            
            
//
//            switch response.result {
//            case .success:
//                print("Validation Successful")
//            case .failure(let error):
//                print(error)
//            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
}
