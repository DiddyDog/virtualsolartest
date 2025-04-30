import SwiftUI
import FirebaseAuth
import GoogleSignInSwift
import GoogleSignIn
import FacebookLogin
import FirebaseCore

struct LoginView: View {
    
    @EnvironmentObject var appState: AppState
    
    let slides = [
        SlideData(image: "Slide1", title: "Solar anywhere, anytime", description: "If you rent or own an apartment or house, or you own a business, SolarCloud works."),
        SlideData(image: "Slide2", title: "Lower energy bills", description: "If you rent or own an apartment or house, or you own business, SolarCloud works."),
        SlideData(image: "Slide3", title: "We make everything easier", description: "If you rent or own an apartment or house, or you own business, SolarCloud works.")
    ]
    
    @State private var selectedIndex = 0
    @State private var loginError: String?

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color("AccentColor4"), location: 0.0),
                        .init(color: Color("BackgroundColor"), location: 0.5),
                        .init(color: Color("AccentColor4"), location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                
                
                VStack {
                    Spacer()
                    
                    TabView(selection: $selectedIndex) {
                        ForEach(0..<slides.count, id: \.self) { index in
                            SlideView(data: slides[index])
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 250)
                    
                    HStack(spacing: 5) {
                        ForEach(0..<slides.count, id: \.self) { index in
                            Circle()
                                .fill(index == selectedIndex ? Color("AccentColor1") : Color.white)
                                .frame(width: 6, height: 6)
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // Social media login
                    VStack(spacing: 10) {
                        SocialLoginButton(title: "Continue with Google", icon: "GoogleIcon") {
                            signInWithGoogle()
                        }
                        
                        SocialLoginButton(title: "Continue with Apple", icon: "AppleIcon") {
                            // Apple login not implemented yet
                        }
                        
                        SocialLoginButton(title: "Continue with Facebook", icon: "FacebookIcon") {
                            signInWithFacebook()
                        }
                    }
                    
                    // Email login
                    HStack {
                        NavigationLink(destination: EmailSignUpView()) {
                            Text("Continue with email")
                                .font(Font.custom("Poppins", size: 16))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: EmailLoginView()) {
                            Text("Login")
                                .font(Font.custom("Poppins", size: 16))
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // Error Message
                    if let error = loginError {
                        Text(error)
                            .font(Font.custom("Poppins", size: 14))
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding()
                
            }
        }
    }
    
    // MARK: - Google Sign-In
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        if let rootViewController = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene }).first?.windows.first?.rootViewController {
            
            GIDSignIn.sharedInstance.configuration = config
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
                if let error = error {
                    loginError = "Google login failed: \(error.localizedDescription)"
                    return
                }
                
                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString else {
                    loginError = "Google token missing"
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { _, error in
                    if let error = error {
                        loginError = "Firebase error: \(error.localizedDescription)"
                    } else {
                        appState.isLoggedIn = true
                    }
                }
            }
        }
    }
    
    // MARK: - Facebook Login
    func signInWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email"], from: nil) { result, error in
            if let error = error {
                loginError = "Facebook login failed: \(error.localizedDescription)"
                return
            }
            
            guard let token = AccessToken.current?.tokenString else {
                loginError = "Facebook token missing"
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            
            Auth.auth().signIn(with: credential) { _, error in
                if let error = error {
                    loginError = "Firebase error: \(error.localizedDescription)"
                } else {
                    appState.isLoggedIn = true
                }
            }
        }
    }
}

// MARK: - Slide & Social Button Views
struct SlideData {
    let image: String // String for custom image names
    let title: String
    let description: String
}

struct SlideView: View {
    let data: SlideData
    
    var body: some View {
        VStack {
            Image(data.image) // Use custom image assets
                .resizable()
                .scaledToFit()
                .frame(height: 70) // Adjust the size as needed
            
            Text(data.title)
                .font(Font.custom("PoppinsSemiBold", size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
            
            Text(data.description)
                .font(Font.custom("Poppins", size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.top, 5)
        }
    }
}

struct SocialLoginButton: View {
    var title: String
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
                Text(title)
                    .font(Font.custom("Poppins", size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.white)
            .cornerRadius(10)
        }
        .padding(.horizontal, 40)
    }
}

#Preview {
    LoginView()
}
