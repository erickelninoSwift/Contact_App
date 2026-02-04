//
//  ContactsViewModel.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/02.
//
import Foundation

@Observable
@MainActor

class ContactsViewModel {
    //
    enum serviceFetchStatus: Equatable{
        case notStarted
        case startedFetching
        case isLoading
        case success
        case failed(String)
    }
    // only the viewmodel wil be able to change this
    var status: serviceFetchStatus = .notStarted
    
    private let contactService = ContactsService()
    var errorMessageFound: String?
    
    var users : [User] = []
    
    func fetchContacts() async {
        
        status = .isLoading
        do {
            self.users = try await contactService.fetchAllUserContact()
            status = .success
    
        }catch{
            status = .failed(error.localizedDescription)
        }
    }
    
}
