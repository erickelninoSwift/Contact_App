//
//  UserModel.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/01.
//
import Foundation

struct User: Decodable, Identifiable, Encodable, Hashable {
    
    // this fields will be whst we should expect form the data received
    let id : Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    
    var userInitials: String {
        
        let firstLetterName = name.prefix(1)
        let firstLetterUsername = username.prefix(1)
        
        return String(firstLetterName + firstLetterUsername)
    }
    
}
