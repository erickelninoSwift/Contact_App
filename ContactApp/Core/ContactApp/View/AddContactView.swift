//
//  AddContactView.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/03.
//

import SwiftUI

struct AddContactView: View {
    @State private var name = ""
    @State private var username = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var website = ""
    
    @Environment(\.dismiss) var dismiss
    
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
                    Button("Save") {
                        // Save the contact
                        print("Saving contact...")
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(name.isEmpty || email.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddContactView()
}
