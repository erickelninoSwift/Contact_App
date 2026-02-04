//
//  FetchContactsService.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/01.
//

import Foundation

struct ContactsService {
    
   private let BASE_URL = Endpoint.contacts.url
    
    // this is our fetch users or contact service
    func fetchAllUserContact() async throws -> [User] {
        // we are making sure that the url is indeed provoided
        
        guard let url = BASE_URL else { throw APIError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        //handle the response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw APIError.invalidResponse}
        
        //DEcode data
        do {
            
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
            
        }catch {
            
            throw APIError.decodingError
        }
    }
    
    // fetch a signle user
    func fetchUser(of userId: Int) async throws -> User {
        guard let url = Endpoint.contact(id: userId).url else { throw APIError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw APIError.invalidResponse }
        
        do {
            
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
            
        } catch {
            throw APIError.decodingError
        }

    }
    
    // update user
    func updateUser(of userId: Int, updatedUser: User) async throws -> User {
        guard let url = Endpoint.contact(id: userId).url else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // we are creating encoder to prepare data to sent to the server
        
        request.httpBody = try JSONEncoder().encode(updatedUser)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else { throw APIError.invalidResponse }
        
        do {
            let userUpdated = try JSONDecoder().decode(User.self, from: data)
            return userUpdated
            
        }catch {
            throw APIError.decodingError
        }
    }
    
    func createUser(of newUser: User) async throws -> User {
        guard let url = Endpoint.contacts.url else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(newUser)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        // i want to log everything to see if it was successfulk
        
        print(" CREATE USER RESPONSE")
        print("Status Code:", httpResponse.statusCode)
        print("Headers:", httpResponse.allHeaderFields)
        
        if let body = String(data: data, encoding: .utf8) {
            print("Body:", body)
        }
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 201 else {
            throw APIError.invalidResponse
        }
        
        do {
            let createdUser = try JSONDecoder().decode(User.self, from: data)
            return createdUser
        } catch {
            throw APIError.decodingError
        }
    }
    
     // this one if for deleting outr user
    func deleteUser(of userId: Int) async throws -> Bool {
        guard let url = Endpoint.contact(id: userId).url else { throw APIError.invalidURL }
        
        //
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        if httpResponse.statusCode == 200 || httpResponse.statusCode == 204 {
            return true
        } else {
            throw APIError.serverError(httpResponse.statusCode)
        }
    }
}
