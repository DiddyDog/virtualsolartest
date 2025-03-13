//
//  TrackerView.swift
//  virtual solar UI
//
//  Created by Lachlan Jiang on 16/3/2025.
//

import SwiftUI

struct TrackerView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack {
                    Image("SolarCloudLogo")
                        .resizable()
                        .frame(width: 28.86, height: 50.0)
                    
                    HStack {
                        Image(systemName: "list.bullet")
                            .foregroundColor(Color("AccentColor1"))
                            .padding()
                        
                        Text("Tracker")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 90.0)
                        
                            
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 50)
                                        
                    Spacer()
                    
                    
                        
                    
                }
            }
        }
    }
}

#Preview {
    TrackerView()
}
