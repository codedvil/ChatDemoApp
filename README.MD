# Chat Demo iOS App

**ChatDemo** project is a demo iOS application for illustrative purposes only.

The app is built with the **iOS SwiftUI SDK** at the frontend and **Firebase** as the backend following the principles of **Clean Architecture**.

**Demo users for testing purposes only**
| Email                                  | Password     | 
|----------------------------------------|--------------|
| edgar.vilchis@edgarcustom.com          | edgarCustom  |
| miprueba@prueba.com                    | miPrueba*    |

## Active requirements
- User Login with **email and password** (Firebase Auth)
- User Register with **email and password** (Firebase Auth + FireStore)
- Displays a **Chats** tab (WIP) and a **Profile** tab
- The Profile tab has a Form with editable elements which, if edited and saved, they're stored within Firebase (Firestore)
- The profile image **can be edited too, and the code tends to save the profile image, but it requires Firebase Storage which acts as Google subscription so it won't be saved until that subscription is paid.**
- The messages tab is a **Work in Progress** tab which tends to use the same Firestore implementation as the Profile tab.

**The app contains the feature to register a new user.** If needed you can register yourself but data may reset periodically.

## Tech Stack
- **iOS App built with Swift**
- **Clean Architecture** principles
- **Firebase Auth** (Login/Register -> Email/Password)
- **Cloud Firestore** (User data, profile image, messages)
- **Xcode 26.3 as development environment**
