//
//  UserApiData.swift
//  UsersApi
//
//  Created by user213590 on 4/8/22.
//

import Foundation
class UserApiData{
     let chave = "userLogin"
    
    func listar() -> [LoginUser]{
        var users  =  UserDefaults.standard.object(forKey: chave)
        if users == nil {
            return []
        }
        let placeData = UserDefaults.standard.object(forKey: chave) as? Data
        users = try! PropertyListDecoder().decode([LoginUser].self, from: placeData!)
    
        return ( users as! [LoginUser] )
    }
    
    func salve(user: LoginUser){
        var users = listar()
        users.append(user)
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(users), forKey: chave)
    }
    func listById(index: Int){
        
    }
}
