//
//  DashboardView.swift
//  virtual solar UI
//
//  Created by Lachlan Jiang on 14/3/2025.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack {
                    Image("SolarCloudLogo")
                        .resizable()
                        .frame(width: 28.86, height: 50.0)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        HStack {
                            Image(systemName: "calendar.badge.clock")
                                .foregroundColor(Color("AccentColor1"))
                                .font(.title2)
                            
                            Text("Dashboard")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 10) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 50)
                                .cornerRadius(10)
                            
                            HStack {
                                Text("Select allocations")
                                    .foregroundColor(.gray)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        VStack {
                            HStack {
                                DashboardCard(title: "Active", value: "10.8kW")
                                DashboardCard(title: "Last quarter", value: "$157.50")
                            }
                            
                            HStack {
                                DashboardCard(title: "Total savings", value: "$2,679.45")
                                DashboardCard(title: "This quarter to date", value: "$52.50")
                            }
                        }
                        
                        Text("Savings")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        Text("Last quarter")
                            .foregroundColor(.gray)
                            .font(.footnote)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("BackgroundColor"))
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}

struct DashboardCard: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color("AccentColor1"))
        }
        .frame(width: 150, height: 100)
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
    }
}

#Preview {
    DashboardView()
}
