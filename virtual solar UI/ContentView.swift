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
        NavigationView{
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack{
                    Text("Login")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 100)
                    
                    Text("Email Address")
                        .foregroundColor(Color.gray)
                        .padding(.trailing, 188)
                    
                    TextField("Email Address", text: $email)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color("AccentColor3"))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("AccentColor1"), lineWidth:2))
                    
                    Text("Password")
                        .foregroundColor(Color.gray)
                        .padding(.trailing, 220)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color("AccentColor3"))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("AccentColor1"), lineWidth:2))
                    
                    Button("Login"){
                        
                    }
                    .padding()
                    .foregroundColor(Color.accentColor3)
                    .frame(width:300, height:50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        
                    }
                        
                    }
                }
                
            }
            .navigationBarBackButtonHidden(true)
        }
        
    }


#Preview {
    ContentView()
}
