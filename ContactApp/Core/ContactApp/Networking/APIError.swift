//
//  APIError.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/01.
//
import Foundation


enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(Int)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .invalidResponse: return "Invalid server response."
        case .decodingError: return "Failed to decode data."
        case .serverError(let code): return "Server error with code \(code)."
        case .unknown(let error): return error.localizedDescription
        }
    }
}

