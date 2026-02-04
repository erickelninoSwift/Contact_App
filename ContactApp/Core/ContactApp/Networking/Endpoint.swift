//
//  Endpoint.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/01.
//

import Foundation

enum Endpoint {
    
    static let baseURl = "https://jsonplaceholder.typicode.com"
    
    case contacts
    case contact(id: Int)
    
    var url: URL? {
        switch self {
        case .contacts:
            return URL(string: "\(Endpoint.baseURl)/users")
        case .contact(let id):
            return URL(string: "\(Endpoint.baseURl)/users/\(id)")
        }
    }
}
