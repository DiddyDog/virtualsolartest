import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EmailLoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var is2FADone = false
    @State private var navigateToProfileSetup = false

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState

    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                VStack {
                    Image("SolarCloudLogo")
                    Image("SolarCloudName")

                    Text("Login")
                        .font(Font.custom("Poppins", size: 40))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 100)

                    Group {
                        Text("Email Address")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                            .font(Font.custom("Poppins", size: 16))

                        TextField("Email Address", text: $email)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color("AccentColor3"))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins", size: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isEmailFocused ? Color("AccentColor1") : Color.clear, lineWidth: 2)
                            )
                            .focused($isEmailFocused)

                        Text("Password")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                            .font(Font.custom("Poppins", size: 16))

                        SecureField("Password", text: $password)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color("AccentColor3"))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins", size: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isPasswordFocused ? Color("AccentColor1") : Color.clear, lineWidth: 2)
                            )
                            .focused($isPasswordFocused)
                    }

                    Button(action: {
                        print("🔐 Login button tapped – starting authentication")
                        authenticateUser()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .frame(width: 300, height: 50)

                            Text("Login")
                                .font(Font.custom("Poppins", size: 18))
                                .foregroundColor(Color("AccentColor3"))
                        }
                    }
                    .padding(.top, 30)

                    if wrongUsername > 0 || wrongPassword > 0 {
                        Text("Incorrect Email or Password")
                            .foregroundColor(.red)
                            .font(Font.custom("Poppins", size: 16))
                    }

                    // Navigate to ProfileSetupView if 2FA is not complete
                    NavigationLink(destination: ProfileSetupView(), isActive: $navigateToProfileSetup) {
                        EmptyView()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }

    func authenticateUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("❌ Firebase login error: \(error.localizedDescription)")
                wrongUsername += 1
                wrongPassword += 1
            } else {
                print("✅ Firebase login successful for: \(email)")
                fetch2FAStatus()
            }
        }
    }

    func fetch2FAStatus() {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }

        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let isVerified = document.data()?["is2FAVerified"] as? Bool ?? false
                print("✅ 2FA status fetched: \(isVerified)")
                if isVerified {
                    appState.isLoggedIn = true // ✅ Direct to DashboardView
                } else {
                    self.navigateToProfileSetup = true // Show setup screen
                }
            } else {
                print("❌ No user document found, assuming 2FA not done")
                self.navigateToProfileSetup = true
            }
        }
    }
}
