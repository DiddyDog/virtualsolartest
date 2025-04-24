import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EmailLoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var is2FADone = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                VStack {
                    Image("SolarCloudLogo")
                    Image("SolarCloudName")

                    Text("Login")
                        .font(Font.custom("Poppins-Light", size: 40))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 100)

                    Group {
                        Text("Email Address")
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                            .font(Font.custom("Poppins-Light", size: 16))

                        TextField("Email Address", text: $email)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color("AccentColor3"))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("AccentColor1"), lineWidth: 2))

                        Text("Password")
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 50)
                            .font(Font.custom("Poppins-Light", size: 16))

                        SecureField("Password", text: $password)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color("AccentColor3"))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("AccentColor1"), lineWidth: 2))
                    }

                    Button("Login") {
                        print("🔐 Login button tapped – starting authentication")
                        authenticateUser()
                    }
                    .foregroundColor(Color("AccentColor3"))
                    .frame(width: 300, height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.top, 30)

                    if wrongUsername > 0 || wrongPassword > 0 {
                        Text("Incorrect Email or Password")
                            .foregroundColor(.red)
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
            .navigationDestination(isPresented: $showingLoginScreen) {
                if is2FADone {
                    DashIconView()
                } else {
                    ProfileSetupView()
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
                self.is2FADone = isVerified
                self.showingLoginScreen = true
                print("✅ 2FA status fetched: \(isVerified)")
            } else {
                print("❌ No user document found, assuming 2FA not done")
                self.is2FADone = false
                self.showingLoginScreen = true
            }
        }
    }
}
