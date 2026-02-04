//
//  ContentView.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/01.
//

import SwiftUI

struct ContentView: View {
    
    @State var isDarkMode = true
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
                                        .navigationTitle("Edit Contact")
                                        .navigationBarTitleDisplayMode(.inline)
                                        .navigationBarBackButtonHidden()
                                    
                                    
                                } label: {
                                    ContactRowView(user: user)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Contacts")
                    .navigationBarTitleDisplayMode(.large)
                    .searchable(text: $searchText, prompt: "Search")
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
                                isAscendingOrder.toggle()
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
                            .presentationDetents([.medium])
                            .presentationBackground(.regularMaterial) 
                    }

                    .overlay {   // overlays don't break navigation titles
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
