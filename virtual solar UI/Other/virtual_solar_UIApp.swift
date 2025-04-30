//
//  virtual_solar_UIApp.swift
//  virtual solar UI
//
//  Created by Lachlan Jiang on 27/2/2025.
//

import SwiftUI
import Firebase
import FacebookCore
import FirebaseAuth

@main
struct virtual_solar_UIApp: App {
    // ✅ Connect AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appState = AppState() // ✅ shared app state

    init() {
            FirebaseApp.configure()
            // Check if user is already signed in
        do {
                    try Auth.auth().signOut()
                    print("🔒 User forcibly signed out on launch.")
                } catch {
                    print("❌ Sign-out failed: \(error.localizedDescription)")
                }

        }
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                NavigationBar()
                    .environmentObject(appState)
            } else {
                LoginView()
                    .environmentObject(appState)
            }
        }
    }
}
