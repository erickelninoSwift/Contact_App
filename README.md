# Contact_App

Contacts Manager App

Overview
A SwiftUI-based contacts management app that allows you to perform CRUD operations on contacts using JSONPlaceholder API with CoreData for local persistence.

Features
* View contact list with pull-to-refresh

* Add new contacts

* Edit existing contacts

* Delete contacts

* Search contacts by name or email

* Sort contacts (name, email, username)

* Offline support with CoreData

* Unit tests included


Technical Details: 

Architecture: MVVM

iOS Version: 17.0+

Frameworks: SwiftUI, CoreData

API: JSONPlaceholder.typicode.com/users/

Dependencies: None (No external libraries)

How to Run the App
Prerequisites:

macOS with Xcode 15 or later

iOS 17.0+ simulator or device

Steps

- Clone or download the project to your Mac

- Open the project in Xcode:

- Double-click the .xcodeproj file

- OR open Xcode → File → Open → Select project folder

- Select a simulator or connected iOS device (iOS 17.0+)

- Build and run the app:

- Click the Play button (▶) in top-left corner

- OR press Cmd + R

- Wait for the app to build and launch in the simulator

API Endpoints Used: 
- GET https://jsonplaceholder.typicode.com/users/ - Fetch contacts

- POST https://jsonplaceholder.typicode.com/users/ - Add contact

- PUT https://jsonplaceholder.typicode.com/users/{id} - Update contact

- DELETE https://jsonplaceholder.typicode.com/users/{id} - Delete contact

Note on API Limitations
JSONPlaceholder is a fake API - it won't actually persist your changes, but will return mock responses. The app uses CoreData to maintain local changes.


App Usage:
* Main Screen: Shows all contacts with search bar and sort options

* Pull down to refresh contacts from API

* Tap + button to add new contact

* Tap any contact to view/edit details

* Swipe left on a contact to delete

* Use search bar to filter contacts

* Tap sort button (top-right) to change sorting



