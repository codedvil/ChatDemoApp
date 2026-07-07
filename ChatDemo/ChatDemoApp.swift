//
//  ChatDemoApp.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct ChatDemoApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var authManager = AuthManager(repository: FirebaseAuthRepository())

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(authManager)
    }
  }
}
