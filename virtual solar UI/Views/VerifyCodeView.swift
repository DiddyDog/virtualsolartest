import SwiftUI

struct VerifyCodeView: View {
    @State private var userCode: String = ""
    let expectedCode: String
    let onVerificationSuccess: () -> Void
    @State private var error = ""

    var body: some View {
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
                    if userCode == expectedCode {
                        onVerificationSuccess()
                    } else {
                        error = "Incorrect code. Please try again."
                    }
                }
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 30)
            }
        }
    }
}
