//
//  MoreView.swift
//  virtual solar UI
//
//  Created by Lachlan Jiang on 16/3/2025.
//

import SwiftUI

struct MoreView: View {
    let settingsOptions = [
        "My Details",
        "Statement",
        "Progess Tracker",
        "Energy Company",
        "Allocations",
        "Video explainer",
        "Legal Document",
        "FAQ",
        "Logout"
        
    ]
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Image("SolarCloudLogo")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.top)
                    
                    HStack {
                        Image(systemName: "person.circle")
                            .foregroundColor(.accentColor)
                        Text("Settings")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        ForEach(settingsOptions, id: \.self) { option in
                            HStack {
                                Text(option)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white.opacity(1))
                            }
                            .padding()
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(24)
                    .padding(.horizontal)
                    
                    
                }
                
            }
        }
    }
}

#Preview {
    MoreView()
}
