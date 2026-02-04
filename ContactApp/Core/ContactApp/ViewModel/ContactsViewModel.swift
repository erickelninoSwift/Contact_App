//
//  ContactsViewModel.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/02.
//
import Foundation
import Observation

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
    // this is our coredata instance
    private let coreData = CoreDataUserManager.shared
    
    var errorMessageFound: String?
    
    var users : [User] = []
    var allUsers: [User] = [];
    
    func fetchContacts() async {
        
        status = .isLoading
        
        // first check core data
        fetchedUserCached()
        
        do {
            let fetchedAPIusers = try await contactService.fetchAllUserContact()
            self.users = fetchedAPIusers
            self.allUsers = fetchedAPIusers
            status = .success
            
            // saved updated list to our coredata
            fetchedAPIusers.forEach { user in
                self.coreData.editAndUpdateUser(user: user)
            }
    
        }catch{
            status = .failed(error.localizedDescription)
        }
    }
    
    // coredata fucntion to fetch users saved
    
    func fetchedUserCached() {
        let fetchedCasedUser = coreData.fetchAllUsers()
        
        
        print("DEBUG COREDATA:: ", fetchedCasedUser)
        
        // in case we have users in our coredata
        if !fetchedCasedUser.isEmpty {
            self.users = fetchedCasedUser
            self.allUsers = fetchedCasedUser
            status = .success
        }
    }
    
   // MARK: -- Add new contact
    
    func createNewContact(name:String, username: String, email: String, phone: String, website: String) async {
        status = .isLoading
        let newUserId = (users.map { $0.id }.max() ?? 0) + 1
        
        let user = User(id: newUserId, name: name, username: username, email: email, phone: phone, website: website)
        
        do {
            let response = try await contactService.createUser(of: user)
            print("success :: \(response)")
            users.insert(user, at: 0)
            status = .success
        }catch {
            status = .failed(error.localizedDescription)
        }
    }
    
    // MARK: - Delete Contact
    func deleteContact(userId: Int) async {
        status = .isLoading
        
        do {
            let success = try await contactService.deleteUser(of: userId)
            
            if success {
                users.removeAll { $0.id == userId }
                print("DELETE SUCCESS: User ID \(userId) removed")
                status = .success
            }
        } catch {
            status = .failed(error.localizedDescription)
        }
    }
    
    // MARK: - Update Contact
    func updateContact(user: User) async {
        status = .isLoading
        
        do {
            let updatedUser = try await contactService.updateUser(of: user.id, updatedUser: user)
            print("UPDATE SUCCESS: \(updatedUser)")
            
            // Replace user in array
            if let index = users.firstIndex(where: { $0.id == user.id }) {
                users[index] = updatedUser
            }
            
            status = .success
        } catch {
            status = .failed(error.localizedDescription)
        }
    }
    //
    func filterByNameUsernameEmail(for search: String) {
        if search.isEmpty {
            users = allUsers
        } else {
            users = allUsers.filter { user in
                user.name.localizedCaseInsensitiveContains(search) ||
                user.username.localizedCaseInsensitiveContains(search) ||
                user.email.localizedCaseInsensitiveContains(search)
            }
        }
    }
    
    func sortCurrentUsers (ascendingOrder: Bool) {
        
        users.sort {
            ascendingOrder
            ? $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            : $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedDescending
        }
    }
    
}
