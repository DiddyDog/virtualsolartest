import SwiftUI

struct LoginView: View {
    let slides = [
        SlideData(image: "sun.max.fill", title: "Solar anywhere, anytime", description: "If you rent or own an apartment or house, or you own a business, SolarCloud works."),
        SlideData(image: "house.fill", title: "Power your home with ease", description: "Enjoy seamless solar energy integration whether you own or rent."),
        SlideData(image: "leaf.fill", title: "Sustainable and cost-effective", description: "Reduce your carbon footprint while saving on energy bills."),
        SlideData(image: "globe", title: "Clean energy, anywhere", description: "Harness the power of the sun, wherever you are.")
    ]
    
    @State private var selectedIndex = 0
    
    var body: some View {
        ZStack {
            // Background color (dark gradient effect)
            LinearGradient(gradient: Gradient(colors: [Color.black, Color("DarkGray")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Marketing Slideshow
                TabView(selection: $selectedIndex) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        SlideView(data: slides[index])
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide default indicators
                .frame(height: 250)

                // Custom Page Indicators
                HStack(spacing: 5) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        Circle()
                            .fill(index == selectedIndex ? Color.green : Color.gray)
                            .frame(width: 6, height: 6)
                    }
                }
                .padding(.top, 10)

                Spacer()

                // Social Media Login Buttons
                VStack(spacing: 10) {
                    SocialLoginButton(title: "Continue with Google", icon: "globe")
                    SocialLoginButton(title: "Continue with Apple", icon: "applelogo")
                    SocialLoginButton(title: "Continue with Facebook", icon: "facebook")
                }

                // Email & Login Options
                HStack {
                    Button(action: {
                        // Handle email sign-in
                    }) {
                        Text("Continue with email")
                            .font(.body)
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Button(action: {
                        // Handle login
                    }) {
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

// MARK: - Slide Data Model
struct SlideData {
    let image: String
    let title: String
    let description: String
}

// MARK: - Slide View
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

// MARK: - Custom Button for Social Login
struct SocialLoginButton: View {
    var title: String
    var icon: String
    
    var body: some View {
        Button(action: {
            // Handle social login action
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
