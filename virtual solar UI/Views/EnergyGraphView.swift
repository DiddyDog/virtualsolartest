//
//  EnergyGraphView.swift
//  virtual solar UI
//
//  Created by 陈祉卓 on 2025/3/24.
//

import SwiftUI
import Charts

struct EnergyData {
    let day: Int
    let value: Double
}

struct EnergyGraphView: View {
    let energyData: [EnergyData] = [
        EnergyData(day: 1, value: 150),
        EnergyData(day: 2, value: 320),
        EnergyData(day: 3, value: 210),
        EnergyData(day: 4, value: 290),
        EnergyData(day: 5, value: 160),
        EnergyData(day: 6, value: 320),
        EnergyData(day: 7, value: 200),
        EnergyData(day: 8, value: 250),
        EnergyData(day: 9, value: 400)
    ]
    
    var body: some View {
        VStack {
            
            // 顶部标题
            Text("My virtual panels")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            // 月份选择
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.3))
                        .clipShape(Circle())
                }
                
                Text("June 2021")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.3))
                        .clipShape(Circle())
                }
            }
            .padding(.top, 5)
            
            // 能量数据
            VStack(spacing: 5) {
                Text("Active")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.7))
                
                Text("10.8kW")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.mint)
            }
            .padding(.top, 5)
            
            
            Chart {
                
                ForEach(energyData, id: \.day) { data in
                    LineMark(
                        x: .value("Day", data.day),
                        y: .value("Kw", data.value)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(Color.mint.opacity(0.7))
                }
                
               
                ForEach(energyData, id: \.day) { data in
                    BarMark(
                        x: .value("Day", data.day),
                        y: .value("Kw", data.value)
                    )
                    .foregroundStyle(data.day == 9 ? Color.orange : Color.mint)
                    .cornerRadius(3)
                    
                    
                    if data.day == 6 {
                        PointMark(
                            x: .value("Day", data.day),
                            y: .value("Kw", data.value)
                        )
                        .foregroundStyle(.blue)
                        .annotation(position: .top) {
                            Text("320kW")
                                .font(.caption)
                                .padding(6)
                                .background(Color.white)
                                .cornerRadius(5)
                        }
                    }
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom)
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 200)
            .padding(.horizontal)
            
        
            HStack {
                Text("Watt")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.caption)
                Spacer()
                Text("Day")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.caption)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
        }
        .padding()
        .background(Color.black.opacity(0.9))
        .cornerRadius(20)
        .padding(.horizontal)
        
        
        HStack {
            VStack {
                Image(systemName: "square.grid.2x2.fill")
                    .foregroundColor(Color.mint)
                Text("Dashboard")
                    .font(.caption)
                    .foregroundColor(Color.mint)
            }
            Spacer()
            VStack {
                Image(systemName: "list.bullet")
                    .foregroundColor(Color.gray)
                Text("Tracker")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            Spacer()
            VStack {
                Image(systemName: "calculator")
                    .foregroundColor(Color.gray)
                Text("Calculator")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            Spacer()
            VStack {
                Image(systemName: "person")
                    .foregroundColor(Color.gray)
                Text("More")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
        }
        .padding()
        .background(Color.black.opacity(0.8))
    }
}


struct EnergyGraphView_Previews: PreviewProvider {
    static var previews: some View {
        EnergyGraphView()
            .preferredColorScheme(.dark)
    }
}
