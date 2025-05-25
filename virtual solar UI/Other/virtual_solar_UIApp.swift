import SwiftUI
import Firebase
import FacebookCore
import FirebaseAuth
import FirebaseAppCheck


@main
struct virtual_solar_UIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appState = AppState()

    init() {
        
        FirebaseApp.configure()

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
                ContentView()
                    .environmentObject(appState)
            }
        }
    }
}
