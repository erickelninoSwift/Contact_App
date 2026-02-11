//
//  ContactsViewModelTests.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/10.
//

@testable import ContactApp
import XCTest

@MainActor

final class ContactsViewModelTests: XCTestCase {
    
    //
    var viewModel : ContactsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ContactsViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSortAscending() {
        
      
        viewModel.users = [
            User(id: 1, name: "Anthony", username: "", email: "", phone: "", website: ""),
            User(id: 2, name: "Erick", username: "", email: "", phone: "", website: ""),
            User(id: 3, name: "Yollande", username: "", email: "", phone: "", website: "")
        ]
        
    
        viewModel.sortCurrentUsers(ascendingOrder: true)
        
        // THEN
        let names = viewModel.users.map { $0.name }
        
        XCTAssertEqual(names, ["Anthony", "Erick", "Yollande"])
    }
    
    func testSortDescending() {
        
        viewModel.users = [
            User(id: 1, name: "Anthony", username: "", email: "", phone: "", website: ""),
            User(id: 2, name: "Erick", username: "", email: "", phone: "", website: ""),
            User(id: 3, name: "Yollande", username: "", email: "", phone: "", website: "")
        ]
        
        viewModel.sortCurrentUsers(ascendingOrder: false)
        
        let names = viewModel.users.map { $0.name }
        
        XCTAssertEqual(names, ["Yollande", "Erick", "Anthony"])
    }
    
    func testFilterByName() {
        
        viewModel.allUsers = [
            User(id: 1, name: "Erick", username: "elnino", email: "erickelnino@test.com", phone: "", website: ""),
            User(id: 2, name: "Anthony", username: "scrappy", email: "anthony@test.com", phone: "", website: "")
        ]
        
    
        viewModel.filterByNameUsernameEmail(for: "eri")
        

        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertEqual(viewModel.users.first?.name, "Erick")
    }
    
    func testFilterByUsername() {
        
        viewModel.allUsers = [
            User(id: 1, name: "Erick", username: "elnino", email: "erickelnino@test.com", phone: "", website: ""),
            User(id: 2, name: "Anthony", username: "scrappy", email: "anthony@test.com", phone: "", website: "")
        ]
        
        viewModel.filterByNameUsernameEmail(for: "scra")
        
        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertEqual(viewModel.users.first?.username, "scrappy")
    }
    
    func testFilterByEmail() {
        
        viewModel.allUsers = [
            User(id: 1, name: "Erick", username: "elnino", email: "erickelnino@test.com", phone: "", website: ""),
            User(id: 2, name: "Anthony", username: "scrappy", email: "anthony@test.com", phone: "", website: "")
        ]
        
        viewModel.filterByNameUsernameEmail(for: "erickelnino")
        
        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertEqual(viewModel.users.first?.email, "erickelnino@test.com")
    }
    
    func testFilterWithEmptySearchReturnsAllUsers() {
        
        viewModel.allUsers = [
            User(id: 1, name: "Erick", username: "elnino", email: "erickelnino@test.com", phone: "", website: ""),
            User(id: 2, name: "Anthony", username: "scrappy", email: "anthony@test.com", phone: "", website: "")
        ]
        
        viewModel.filterByNameUsernameEmail(for: "")
        
        XCTAssertEqual(viewModel.users.count, 2)
    }
    
}
