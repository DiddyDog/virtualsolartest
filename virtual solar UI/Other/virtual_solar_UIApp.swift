//
//  virtual_solar_UIApp.swift
//  virtual solar UI
//
//  Created by Lachlan Jiang on 27/2/2025.
//

import SwiftUI
import Firebase
import FacebookCore

@main
struct virtual_solar_UIApp: App {
    // ✅ Connect AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appState = AppState() // ✅ shared app state

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
