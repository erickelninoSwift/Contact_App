import SwiftUI

struct ContactsListView: View {
    
    // MARK: - State
    @State private var searchText = ""
    @State private var sortAscending = true
    
    // MARK: - Mock Data
    @State private var contacts: [Contact] = [
        Contact(name: "Liam Johnson", phone: "+1 555 1234", email: "liam@email.com"),
        Contact(name: "Emma Williams", phone: "+1 555 5678", email: "emma@email.com"),
        Contact(name: "Noah Brown", phone: "+1 555 8765", email: "noah@email.com"),
        Contact(name: "Olivia Jones", phone: "+1 555 4321", email: "olivia@email.com"),
        Contact(name: "Ava Garcia", phone: "+1 555 9988", email: "ava@email.com"),
        Contact(name: "William Miller", phone: "+1 555 2233", email: "will@email.com")
    ]
    
    // MARK: - Filtered + Sorted Contacts
    var filteredContacts: [Contact] {
        let filtered = searchText.isEmpty
        ? contacts
        : contacts.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        return filtered.sorted {
            sortAscending
            ? $0.name < $1.name
            : $0.name > $1.name
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // MARK: - Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    
                    TextField("Search contacts...", text: $searchText)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(12)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding()
                
                // MARK: - Contacts List
                List {
                    ForEach(filteredContacts) { contact in
                        ContactRow(contact: contact)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sortAscending.toggle()
                    } label: {
                        Image(systemName: sortAscending ? "arrow.up.arrow.down.circle.fill" : "arrow.up.arrow.down.circle")
                            .font(.title3)
                    }
                }
            }
            .background(
                LinearGradient(
                    colors: [Color(.systemBackground), Color.blue.opacity(0.05)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
    }
}


// MARK: - Contact Model
struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
    let email: String
}

// MARK: - Contact Row UI
struct ContactRow: View {
    let contact: Contact
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 50)
                .overlay(
                    Text(initials)
                        .font(.headline)
                        .foregroundStyle(.white)
                )
                .shadow(radius: 4)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(contact.name)
                    .font(.headline)
                
                Text(contact.phone)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
    
    var initials: String {
        contact.name
            .split(separator: " ")
            .compactMap { $0.first }
            .prefix(2)
            .map { String($0) }
            .joined()
    }
}


#Preview {
    ContactsListView()
}
