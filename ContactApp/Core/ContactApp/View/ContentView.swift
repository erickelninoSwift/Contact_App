//
//  ContentView.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/01.
//

import SwiftUI

struct ContentView: View {
    // this was later consider after futher reaseach as i was about to implement Core data
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true
    @State var showAddContactView = false
    @State var isAscendingOrder: Bool =  false
    @State var contactVM = ContactsViewModel()

    
    @State var searchText = ""
    var body: some View {
        TabView {
            
            Tab ("Contacts", systemImage: "phone.fill") {
                
                NavigationStack {
                    List {
                        if contactVM.status == .success {
                            ForEach(contactVM.users) { user in
                                NavigationLink {
                                    EditContactView(user: user)
                                        .environment(contactVM)
                                        .navigationTitle("Edit Contact")
                                        .navigationBarTitleDisplayMode(.inline)
                                        .navigationBarBackButtonHidden()
                                    
                                    
                                } label: {
                                    ContactRowView(user: user)
                    
                                }.swipeActions {
                                    Button {
                                        // async function
                                        Task {
                                            await contactVM.deleteContact(userId: user.id)
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }.tint(.red)
                                }
                            }
                        }
                    }
                    .refreshable {
                        await contactVM.fetchContacts()
                    }
                    .navigationTitle("Contacts")
                    .navigationBarTitleDisplayMode(.large)
                    .searchable(text: $searchText, prompt: "Search")
                    .onChange(of: searchText) {
                        contactVM.filterByNameUsernameEmail(for: searchText)
                    }
                    .toolbar {
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                showAddContactView.toggle()
                            } label: {
                                Image(systemName: "plus")
                                    .symbolEffect(.pulse)
                            }
                        }
                        
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
//                                contactVM.sortCurrentUsers(ascendingOrder: isAscendingOrder.toggle())
                                isAscendingOrder.toggle()
                                contactVM.sortCurrentUsers(ascendingOrder: isAscendingOrder)
                            } label: {
                                Label(
                                    isAscendingOrder ? "A–Z" : "Z–A",
                                    systemImage: "textformat"
                                )
                            }
                        }
                        
                    }
                    .sheet(isPresented: $showAddContactView) {
                            AddContactView()
                            .environment(contactVM)
                            .presentationDetents([.medium])
                            .presentationBackground(.regularMaterial) 
                    }

                    .overlay {
                        switch contactVM.status {
                        case .isLoading:
                            ProgressView("Loading Contacts...")
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                        case .failed(let message):
                            VStack(spacing: 12) {
                                Image(systemName: "wifi.exclamationmark")
                                    .font(.largeTitle)
                                Text(message)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                        default:
                            EmptyView()
                        }
                    }
                    .task {
                        if contactVM.status == .notStarted {
                            await contactVM.fetchContacts()
                        }
                    }
                }
            }
            
            Tab ("Settings", systemImage: "gearshape.fill") {
                NavigationStack {
                    List {

                        Section("Appearance") {
                            Toggle(isOn: $isDarkMode) {
                                Label("Dark Mode", systemImage: "moon.fill")
                            }
                        }
                        
                        Section("About") {
                            HStack {
                                Label("App Version", systemImage: "info.circle.fill")
                                Spacer()
                                Text("1.0.0")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .navigationTitle("Settings")
                }
            }
        }.preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
}

#Preview {
    ContentView()
}
