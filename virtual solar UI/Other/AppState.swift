import Foundation
import FirebaseAuth

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = Auth.auth().currentUser != nil
}
