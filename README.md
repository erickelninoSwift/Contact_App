# Contact_App

Contacts Manager App

### Overview
A SwiftUI-based contacts management app that allows you to perform CRUD operations on contacts using JSONPlaceholder API with CoreData for local persistence.

### Main Features
1. **View Contacts**: All contacts are displayed in a list
2. **Search**: Type in the search bar to filter contacts
3. **Sort**: Tap sort button (top-right) to change sorting
4. **Pull-to-Refresh**: Pull down to refresh from API
5. **Add Contact**: Tap + button to add new contact
6. **Edit Contact**: Tap any contact to view/edit details
7. **Delete**: Swipe left on a contact to delete

## Tech Stack
- **Language**: Swift 5
- **Framework**: SwiftUI
- **Minimum iOS**: 17.0+
- **Architecture**: MVVM
- **Persistence**: CoreData
- **Networking**: URLSession
- **Dependencies**: None (100% native)

##  Getting Started

### Prerequisites
- macOS with Xcode 15+
- iOS 17.0+ simulator or device

### Installation

1. **Open the project in Xcode**
\`\`\`bash
cd "*/ContactApp"
open ContactApp.xcodeproj
\`\`\`

2. **Build and Run**
- Select a simulator or device (iOS 17.0+)
- Press \`Cmd + R\` or click the Run button


### API Endpoints Used: 
- GET https://jsonplaceholder.typicode.com/users/ - Fetch contacts

- POST https://jsonplaceholder.typicode.com/users/ - Add contact

- PUT https://jsonplaceholder.typicode.com/users/{id} - Update contact

- DELETE https://jsonplaceholder.typicode.com/users/{id} - Delete contact

### Note on API Limitations
JSONPlaceholder is a fake API - it won't actually persist your changes, but will return mock responses. The app uses CoreData to maintain local changes.


### Main Features
1. **View Contacts**: All contacts are displayed in a list
2. **Search**: Type in the search bar to filter contacts
3. **Sort**: Tap sort button to change sorting order
4. **Pull-to-Refresh**: Pull down to refresh from API
5. **Add Contact**: Tap + button to add new contact
6. **Edit Contact**: Tap any contact to view/edit details
7. **Delete**: Swipe left on a contact to delete

## App Screens
- **ContentView**: Main contact list with search and sort
- **AddContactView**: Form to add new contacts
- **EditContactView**: Form to edit existing contacts
- **ContactRowView**: Individual contact row in list

## Architecture
- **Model**: \`UserModel.swift\` - Defines contact data structure
- **View**: SwiftUI views for UI presentation
- **ViewModel**: \`ContactsViewModel.swift\` - Manages state and business logic
- **Networking**: Handles API communication
- **CoreData**: Local persistence layer

### Tests/
- Unit test files for testing search / filter and sorting features Only
