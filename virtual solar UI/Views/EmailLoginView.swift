import SwiftUI
import FirebaseCore
import FirebaseAuth
import AuthenticationServices

struct EmailLoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
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

                    Button("Login") {
                        authenticateUser()
                    }
                    .foregroundColor(Color("AccentColor3"))
                    .frame(width: 300, height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.top, 30.0)

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
                        HStack {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundStyle(Color.white)
                    }
                }
            }
            .navigationDestination(isPresented: $showingLoginScreen) {
                ProfileSetupView()
            }
        }
    }

    func authenticateUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Firebase login error: \(error.localizedDescription)")
                wrongUsername += 1
                wrongPassword += 1
            } else {
                showingLoginScreen = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        EmailLoginView()
    }
}
