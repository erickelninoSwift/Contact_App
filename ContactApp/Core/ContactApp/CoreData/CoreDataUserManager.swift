//
//  UserCDManager.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/04.
//
import CoreData

class CoreDataUserManager {
    
    static let shared = CoreDataUserManager()
    private let context = PersistenceController.shared.context
    
    private init () {}
    
    func fetchAllUsers() -> [User] {
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        
        print("coredata data :\(request)")
        do {
            let cdUsers = try context.fetch(request)
            
            print("=== CORE DATA DUMP ===")
            print("Total users in CoreData: \(cdUsers.count)")
            
            for (index, entity) in cdUsers.enumerated() {
                print("User \(index):")
                print("  ID: \(entity.id)")
                print("  Name: \(entity.name ?? "nil")")
                print("  Email: \(entity.email ?? "nil")")
                print("  Phone: \(entity.phone ?? "nil")")
                print("  Username: \(entity.username ?? "nil")")
                print("  Website: \(entity.website ?? "nil")")
                print("---")
            }
            print("=====================")
            return cdUsers.map { $0.converetdUserObject() }
        } catch {
            print("Failed to fetch from Core Data: \(error)")
            return []
        }
    }
    
    
    // MARK: - Add User
    func createuser(user: User) {
        let cdUser = CDUser(context: context)
        cdUser.id = Int64(user.id)
        cdUser.name = user.name
        cdUser.username = user.username
        cdUser.email = user.email
        cdUser.phone = user.phone
        cdUser.website = user.website
        
        saveContext()
    }
    
    func editAndUpdateUser(user: User) {
        
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        // her will be the query to fetch the user
        request.predicate = NSPredicate(format: "id == %d", user.id)
        
        if let cdUser = try? context.fetch(request).first {
            cdUser.name = user.name
            cdUser.username = user.username
            cdUser.email = user.email
            cdUser.phone = user.phone
            cdUser.website = user.website
            saveContext()
        }
    }
    // delete our user
    
    func deleteUser(userId: Int) {
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", userId)
        
        if let cdUser = try? context.fetch(request).first {
            context.delete(cdUser)
            saveContext()
        }
    }
    
    func deleteAllUsers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDUser.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("All users deleted from Core Data")
        } catch {
            print("Failed to delete all users: \(error)")
        }
    }
    // after removing all our currentcoredata data we need to replace all users
    func replaceAllUsers(with users: [User]) {
        deleteAllUsers()
        
        for user in users {
            let cdUser = CDUser(context: context)
            cdUser.id = Int64(user.id)
            cdUser.name = user.name
            cdUser.username = user.username
            cdUser.email = user.email
            cdUser.phone = user.phone
            cdUser.website = user.website
        }
        
        saveContext()
    }
    

    // MARK: -- this will help us to save any changes made in our app
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}


// basically we will be expeding our User Datatype that will return data transform ready our user model
// this will tranform data fetched from Coredata to the right user model our appp

extension CDUser {
    
    func converetdUserObject () -> User {
        return User(
            id: Int(id),
            name: name ?? "",
            username: username ?? "",
            email: email ?? "",
            phone: phone ?? "",
            website: website ?? ""
        )
    }
}
