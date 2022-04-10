//
//  requestApi.swift
//  UsersApi
//
//  Created by user213590 on 4/9/22.
//

import Foundation

class  requestApi{
    
    func getRequest(url : String, method: String) -> URLRequest{
        var request = URLRequest(url: URL(string :url)!)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    
}
