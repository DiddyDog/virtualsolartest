
import SwiftUI

struct ProfileSetupView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var is2FAVerified = false
    @State private var showVerifyCodeView = false
    @State private var navigateToDashboard = false
    @State private var showSuccessPopup = false
    @State private var code: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                VStack(spacing: 25) {
                    Image("SolarCloudLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.top, 20)

                    Text("Your profile name")
                        .font(.title)
                        .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Your name")
                            .foregroundColor(.gray)

                        TextField("Your name", text: $name)
                            .padding()
                            .background(Color("AccentColor3"))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.cyan, lineWidth: 1)
                            )

                        Text("Your Email")
                            .foregroundColor(.gray)

                        TextField("you@example.com", text: $email)
                            .padding()
                            .background(Color("AccentColor3"))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 30)

                    Button(action: {
                        sendCodeToEmail()
                    }) {
                        Text("Setup two factor authentication")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("AccentColor3"))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)

                    Button(action: {
                        navigateToDashboard = true
                    }) {
                        Text("Continue")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(is2FAVerified ? Color.white : Color.gray.opacity(0.5))
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 30)
                    .disabled(!is2FAVerified)

                    // Navigation to VerifyCodeView
                    NavigationLink(
                        destination: VerifyCodeView(
                            expectedCode: code,
                            onVerificationSuccess: {
                                is2FAVerified = true
                                showSuccessPopup = true
                            }
                        ),
                        isActive: $showVerifyCodeView
                    ) {
                        EmptyView()
                    }

                    // Navigation to Dashboard
                    NavigationLink(
                        destination: DashIconView(),
                        isActive: $navigateToDashboard
                    ) {
                        EmptyView()
                    }
                }

                // 2FA success popup
                if showSuccessPopup {
                    VStack {
                        Spacer()
                        Text("✅ 2FA Successful!")
                            .foregroundColor(.green)
                            .font(.headline)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Spacer()
                    }
                    .transition(.scale)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSuccessPopup = false
                        }
                    }
                }
            }
        }
    }

    func sendCodeToEmail() {
        let randomCode = String(format: "%06d", Int.random(in: 100000...999999))
        self.code = randomCode

        let payload: [String: Any] = [
            "personalizations": [[
                "to": [["email": email]],
                "subject": "Your SolarCloud Verification Code"
            ]],
            "from": ["email": "abubakarabbas790@gmail.com"],
            "content": [[
                "type": "text/plain",
                "value": "Hi \(name),\n\nYour SolarCloud verification code is: \(randomCode)"
            ]]
        ]

        guard let url = URL(string: "https://api.sendgrid.com/v3/mail/send"),
              let body = try? JSONSerialization.data(withJSONObject: payload) else {
            print("❌ Failed to encode request body")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(Secrets.sendGridKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("❌ Failed to send email: \(error.localizedDescription)")
                } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 202 {
                    print("✅ Code sent to \(email): \(randomCode)")
                    showVerifyCodeView = true
                } else {
                    print("❌ Error sending email or invalid response")
                }
            }
        }.resume()
    }
}
