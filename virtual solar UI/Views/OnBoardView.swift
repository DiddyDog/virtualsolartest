//
// Ongoing.swift
//  VirtualSolar
//
//  Created by Abubakar Abbas on 5/3/2025.
//

import SwiftUI

struct OnBoardView: View {
    @State private var isActive = false
    @State private var opacity = 0.0

    var body: some View {
        if isActive {
            MainView() // Replace with your main screen
        } else {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.8)]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    // App Logo
                    Image("SolarCloudLogo") // Ensure you add this image to Assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.5)) {
                                opacity = 1.0
                            }
                        }
                    
                    // App Name
                    Text("SOLAR")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.yellow)
                        + Text("CLOUD")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.gray)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

// Main App View Placeholder
struct MainView: View {
    var body: some View {
        Text("Welcome to SolarCloud!")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView()
    }
}



