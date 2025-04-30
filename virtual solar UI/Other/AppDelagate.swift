import UIKit
import Firebase
import FacebookCore
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        // ✅ Set the App Check Debug Provider BEFORE FirebaseApp.configure()
        #if DEBUG
        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        #endif

        // ✅ Then configure Firebase
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }

        print("✅ App Check Debug Mode setup done. Awaiting token...")

        // Facebook login
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
}
