//
//  Untitled.swift
//  virtual solar UI
//
//  Created by 陈祉卓 on 2025/3/13.
//

import SwiftUI

struct NavigationBar: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack {
                Spacer()
                
                switch selectedTab {
                case 0:
                    DashboardView()
                case 1:
                    TrackerView()
                case 2:
                    CalculatorView()
                case 3:
                    MoreView()
                default:
                    NavigationBar()
                }
                
                CustomTabBar(selectedTab: $selectedTab)
                    .background(
                        Rectangle()
                            .fill(Color("BackgroundColor"))
                            .frame(height: 60)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: -5)
                    )
            }
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            TabBarButton(icon: "SolarIcon", text: "Dashboard", isSelected: selectedTab == 0)
                .onTapGesture {
                    selectedTab = 0
                }
            
            Spacer()
            
            TabBarButton(icon: "list.bullet", text: "Tracker", isSelected: selectedTab == 1)
                .onTapGesture {
                    selectedTab = 1
                }
            
            Spacer()
            
            TabBarButton(icon: "calculator", text: "Calculator", isSelected: selectedTab == 2)
                .onTapGesture {
                    selectedTab = 2
                }
            
            Spacer()
            
            TabBarButton(icon: "person.circle", text: "More", isSelected: selectedTab == 3)
                .onTapGesture {
                    selectedTab = 3
                }
        }
        .padding(.horizontal)
        .frame(height: 60)
        .background(Color("BackgroundColor"))
    }
}

struct TabBarButton: View {
    var icon: String
    var text: String
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(isSelected ? Color("AccentColor1") : .white)
                
            
            Text(text)
                .foregroundColor(isSelected ? Color("AccentColor1") : .white)
                .padding(.top, 3.0)
            
        }
    }
}

#Preview {
    NavigationBar()
}
