//
//  CalculatorView.swift
//  virtual solar UI
//
//  Created by Lachlan Jiang on 16/3/2025.
//

import SwiftUI

struct CalculatorView: View {
    @State private var billAmount: String = "450"
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    VStack(spacing: 8) {
                        Image("SolarCloudLogo")
                            .resizable()
                            .frame(width: 40, height: 40)
                        
                        HStack {
                            Image(systemName: "doc.text.magnifyingglass")
                                .foregroundColor(.accentColor)
                            Text("Calculator")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    VStack(spacing: 12) {
                        Text("Find out your solar saving")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Enter your Electricity Bill")
                            .foregroundColor(.gray)
                        
                        TextField("450", text: $billAmount)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.2)))
                        
                    }
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(16)
                    
                    Text("Solar saving\n$250 monthly*")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        
                    
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 12) {
                        ForEach(0..<4) { _ in
                            VStack(spacing: 8) {
                                Text("This month\n saving")
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                Text("$234")
                                    .font(.headline)
                                    .foregroundColor(Color("AccentColor2"))
                            }
                            .padding()
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(12)
                        }
                    }
                    HStack(alignment: .center, spacing: 24) {
                        
                        ZStack {
                            Circle()
                                .trim(from: 0, to: 0.35)
                                .stroke(Color("AccentColor1"), lineWidth: 12)
                                .rotationEffect(.degrees(-90))
                            
                            Text("35% \nsaving")
                                .font(.caption)
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                        .frame(width: 120, height: 120)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Electricity bill")
                                Spacer()
                                Text("$\(billAmount)")
                                    .bold()
                                    .foregroundColor(Color("AccentColor2"))
                            }
                            HStack {
                                Text("Solar Payout")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$250")
                                    .bold()
                                    .foregroundColor(Color("AccentColor2"))
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    
                    VStack(spacing: 6) {
                        Text("To eliminate your Electricity Bill visit our ")
                            .foregroundColor(.gray)
                        + Text("website")
                            .foregroundColor(.blue)
                            .underline()
                        + Text(" to update your SolarCloud portfolio.")
                        
                        Text("*Terms and conditions of savings If you rent or own an apartment or house, or your own business, SolarCloud works")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
    }
}

#Preview {
    CalculatorView()
}
