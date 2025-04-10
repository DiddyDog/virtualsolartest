import SwiftUI

struct LoginView: View {
    let slides = [
        SlideData(image: "sun.max.fill", title: "Solar anywhere, anytime", description: "If you rent or own an apartment or house, or you own a business, SolarCloud works."),
        SlideData(image: "house.fill", title: "Lower energy bills", description: "If you rent or own an apartment or house, or you own business, SolarCloud works"),
        SlideData(image: "leaf.fill", title: "We make everything easier", description: "If you rent or own an apartment or house, or you own business, SolarCloud works"),
        SlideData(image: "globe", title: "Clean energy, anywhere", description: "Harness the power of the sun, wherever you are.")
    ]
    
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                //background
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color("AccentColor4"), location: 0.0),  //top color
                        .init(color: Color("BackgroundColor"), location: 0.5),  //middle color
                        .init(color: Color("AccentColor4"), location: 1.0)   //bottom color
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    //slides
                    TabView(selection: $selectedIndex) {
                        ForEach(0..<slides.count, id: \.self) { index in
                            SlideView(data: slides[index])
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide default indicators
                    .frame(height: 250)
                    
                    //slideshow indicator
                    HStack(spacing: 5) {
                        ForEach(0..<slides.count, id: \.self) { index in
                            Circle()
                                .fill(index == selectedIndex ? Color("AccentColor1") : Color.white)
                                .frame(width: 6, height: 6)
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    //social media login
                    VStack(spacing: 10) {
                        SocialLoginButton(title: "Continue with Google", icon: "globe")
                        SocialLoginButton(title: "Continue with Apple", icon: "applelogo")
                        SocialLoginButton(title: "Continue with Facebook", icon: "facebook")
                    }
                    
                    //email login
                    HStack {
                        NavigationLink(destination: EmailSignUpView()) {
                            Text("Continue with email")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: EmailLoginView()) {
                            Text("Login")
                                .font(.body)
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

// MARK: slide data
struct SlideData {
    let image: String
    let title: String
    let description: String
}

// MARK: slide view
struct SlideView: View {
    let data: SlideData
    
    var body: some View {
        VStack {
            Image(systemName: data.image) // Placeholder for solar logo
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text(data.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            Text(data.description)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.top, 5)
        }
    }
}

// MARK: custom button for social login
struct SocialLoginButton: View {
    var title: String
    var icon: String
    
    var body: some View {
        Button(action: {
            //handle social login action
        }) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.black)
                Text(title)
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
