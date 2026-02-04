//
//  AddContactView.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/03.
//

import SwiftUI

struct AddContactView: View {
    
    @Environment(ContactsViewModel.self) var viewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var username = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var website = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Contact Info") {
                    TextField("Name", text: $name)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Section("Additional Info") {
                    TextField("Username", text: $username)
                        .autocapitalization(.none)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    TextField("Website", text: $website)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .navigationTitle("New Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.createNewContact(
                                name: name,
                                username: username,
                                email: email,
                                phone: phone,
                                website: website
                            )
                        }
                        // in case we have succeed
                        if viewModel.status == .success {
                            dismiss()
                        }
                    } label: {
                        if viewModel.status == .isLoading {
                            ProgressView()
                        } else {
                            Text("Save")
                                .fontWeight(.semibold)
                            
                        }
                    }
                    .fontWeight(.semibold)
                    .disabled(name.isEmpty || email.isEmpty || viewModel.status == .isLoading)
                }
            }
        }
    }
}

#Preview {
    AddContactView()
        .environment(ContactsViewModel())
}
