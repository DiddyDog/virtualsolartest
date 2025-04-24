import SwiftUI
import FirebaseCore
import FirebaseAuth

struct EmailSignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showingSignUpScreen = false
    @State private var passwordMismatch = false
    @State private var signupErrorMessage: String?
    @Environment(\.dismiss) var dismiss

    @FocusState private var focusedField: Field?
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password, confirmPassword
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                VStack {
                    Image("SolarCloudLogo")
                    Image("SolarCloudName")

                    Text("Sign Up")
                        .font(Font.custom("Poppins-Light", size: 40))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 50)

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
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(focusedField == .email ? Color("AccentColor1") : Color.clear, lineWidth: 2)
                        )
                        .focused($focusedField, equals: .email)
                    

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
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(focusedField == .password ? Color("AccentColor1") : Color.clear, lineWidth: 2)
                        )
                        .focused($focusedField, equals: .password)
                    
                    Text("Confirm Password")
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 50)
                        .font(Font.custom("Poppins-Light", size: 16))

                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color("AccentColor3"))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(focusedField == .confirmPassword ? Color("AccentColor1") : Color.clear, lineWidth: 2)
                        )
                        .focused($focusedField, equals: .confirmPassword)
                    
                    Button("Sign Up") {
                        signUpUser()
                    }
                    .foregroundColor(Color("AccentColor3"))
                    .frame(width: 300, height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.top, 30.0)

                    if passwordMismatch {
                        Text("Passwords do not match")
                            .foregroundColor(.red)
                    }

                    if let error = signupErrorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
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
            .navigationDestination(isPresented: $showingSignUpScreen) {
                EmailLoginView()
            }
        }
    }

    func signUpUser() {
        guard password == confirmPassword else {
            passwordMismatch = true
            return
        }

        passwordMismatch = false
        signupErrorMessage = nil

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Firebase signup error: \(error.localizedDescription)")
                signupErrorMessage = error.localizedDescription
            } else {
                showingSignUpScreen = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        EmailSignUpView()
    }
}
