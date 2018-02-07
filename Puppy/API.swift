//
//  API.swift
//  Puppy
//
//  Created by Arif De Sousa on 2/7/18.
//  Copyright © 2018 arifads. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire


class API {
    private static let url = "http://www.recipepuppy.com/api"
    
    
    class func queryRecipe(q: String) -> Promise<[QueryResult]> {
        
        let params = ["q": q]
        let request = Alamofire.request(url, parameters: params)
        
        return request.responseData()
        .then { data -> [QueryResult] in
            let decoder = JSONDecoder()
            let response = try decoder.decode(Response.self, from: data)
            return response.results
        }
    }
    
    class func downloadImage(href: String) -> Promise<Data> {
        let request = Alamofire.request(href)
        return request.responseData()
    }
}
