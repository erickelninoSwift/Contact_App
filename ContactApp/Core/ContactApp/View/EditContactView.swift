//
//  EditContactView.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/03.
//

import SwiftUI

struct EditContactView: View {
    @Environment(\.dismiss) var dismiss
    @State private var user: User
    
    // this will allow us to use the very same object recieved and manipulate
    init(user: User) {
        _user = State(initialValue: user)
    }
    
    var body: some View {

        VStack {
            
            Form {
                Section("Contact Info") {
                    TextField("Name", text: $user.name)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    TextField("Email", text: $user.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    TextField("Phone", text: $user.phone)
                        .keyboardType(.phonePad)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Section("Additional Info") {
                    TextField("Username", text: $user.username)
                        .autocapitalization(.none)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    TextField("Website", text: $user.website)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
              // this is our clocing bracket form
            }
            
            Button(role: .destructive) {
                print("we are deleteing user : \(user.name)")
            } label: {
                Text("Delete Contact")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 35)
            
        }.toolbar {
            
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
                .disabled(user.name.isEmpty || user.email.isEmpty)
            }
            
        }
       
    }
}

#Preview {
    EditContactView(user: .init(id: 10, name: "Erick", username: "Elnino", email: "erick@yahoo.com", phone: "0841124598", website: "www.elnino.com"))
}
