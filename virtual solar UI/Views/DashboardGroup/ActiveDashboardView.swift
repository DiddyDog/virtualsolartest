import SwiftUI

struct ActiveDashboardView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Allocation Dropdown, change to a button for a seperate view in a new folder inside of DashboardGroup
                HStack {
                    Text("Select allocations")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

                // Info Cards
                VStack(spacing: 15) {
                    HStack(spacing: 15) {
                        //InfoCard(title: "Active", value: "10.8kW")
                        //InfoCard(title: "Last quarter", value: "$157.50")
                    }
                    HStack(spacing: 15) {
                        //InfoCard(title: "Total savings", value: "$2,679.45")
                        //InfoCard(title: "This quarter to date", value: "$52.50")
                    }
                }

                // Savings Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Savings")
                        .font(.title3)
                        .foregroundColor(.white)

                    HStack {
                        VStack {
                            ZStack {
                                Circle()
                                    .stroke(Color("AccentColor1"), lineWidth: 8)
                                    .frame(width: 90, height: 90)
                                Text("35 %\nsaving")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Electricity bill")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("$450")
                                    .font(.headline)
                                    .foregroundColor(.yellow)
                            }
                            HStack {
                                Text("Solar payout")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("$250")
                                    .font(.headline)
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(15)

                    Text("To eliminate your Electricity Bill visit our website to update your SolarCloud portfolio.")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                .padding(.horizontal)

                // Active Panels Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("My active panels")
                        .foregroundColor(.white)
                        .font(.title3)

                    HStack {
                        Button(action: {}) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Text("June 2021")
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }
                    }

                    Text("Total Energy")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("18155 kW")
                        .font(.headline)
                        .foregroundColor(Color("AccentColor1"))

                    HStack(alignment: .bottom, spacing: 6) {
                        ForEach(1..<10) { i in
                            VStack {
                                if i == 6 {
                                    Text("320kW")
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                }
                                Rectangle()
                                    .fill(i == 9 ? Color.yellow : Color("AccentColor1"))
                                    .frame(width: 14, height: CGFloat(arc4random_uniform(200) + 100))
                            }
                        }
                    }
                    .frame(height: 200)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    ActiveDashboardView()
}
