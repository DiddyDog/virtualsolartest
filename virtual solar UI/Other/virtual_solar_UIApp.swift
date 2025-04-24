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
    // ✅ Connect to the AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        // ✅ Initialize Firebase
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
