import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct VerifyCodeView: View {
    @State private var userCode: String = ""
    let expectedCode: String
    @State private var error = ""
    @State private var goToDashboard = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Enter the code sent to your email")
                        .foregroundColor(.white)
                        .font(.title3)

                    TextField("Enter 6-digit code", text: $userCode)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color("AccentColor3"))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)

                    if !error.isEmpty {
                        Text(error)
                            .foregroundColor(.red)
                    }

                    Button("Verify") {
                        verifyCode()
                    }
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                }

                NavigationLink(destination: DashIconView(), isActive: $goToDashboard) {
                    EmptyView()
                }
            }
        }
    }

    private func verifyCode() {
        if userCode == expectedCode {
            guard let uid = Auth.auth().currentUser?.uid else {
                error = "User not logged in"
                return
            }

            let db = Firestore.firestore()
            db.collection("users").document(uid).setData(["is2FAVerified": true], merge: true) { err in
                if let err = err {
                    error = "Failed to update status: \(err.localizedDescription)"
                } else {
                    goToDashboard = true
                }
            }
        } else {
            error = "Incorrect code. Please try again."
        }
    }
}
