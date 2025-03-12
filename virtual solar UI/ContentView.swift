//
//  ContentView.swift
//  virtual solar UI
//
//  Created by Lachlan Jiang on 27/2/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 100)
                    
                    Text("Email Address")
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 50)
                    
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
                    .padding()
                    .foregroundColor(Color("AccentColor3"))
                    .frame(width: 300, height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    
                    if wrongUsername > 0 || wrongPassword > 0 {
                        Text("Incorrect Email or Password")
                            .foregroundColor(.red)
                    }
                    
                    NavigationLink(destination: Text("You are logged in @\(email)"), isActive: $showingLoginScreen) {
                        EmptyView()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func authenticateUser() {
        if email.lowercased() == "test@example.com" && password == "password123" {
            showingLoginScreen = true
        } else {
            wrongUsername += 1
            wrongPassword += 1
        }
    }
}

#Preview {
    ContentView()
}
