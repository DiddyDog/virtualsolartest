//
//  EmailSignUpView.swift
//  virtual solar UI
//
//  Created by Lachlan Jiang on 20/3/2025.
//

import SwiftUI
import FirebaseCore

struct EmailSignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showingSignUpScreen = false
    @State private var passwordMismatch = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack {
                    Image("SolarCloudLogo")
                        .resizable()
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
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("AccentColor1"), lineWidth: 2))
                    
                    Button("Sign Up") {
                        if password == confirmPassword {
                            showingSignUpScreen = true
                            passwordMismatch = false
                        } else {
                            passwordMismatch = true
                        }
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
                DashIconView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        EmailSignUpView()
    }
}
