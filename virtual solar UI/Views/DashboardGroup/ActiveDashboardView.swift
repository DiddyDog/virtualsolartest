import SwiftUI

struct ActiveDashboardView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    
                    // MARK: - Allocation Navigation Button
                    HStack {
                        NavigationLink(destination: AllocationView()) {
                            HStack {
                                Text("Select allocations")
                                    .font(.custom("PoppinsSemiBold", size: 16))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)

                    // MARK: - Savings
                    VStack(alignment: .leading, spacing: 25) {
                        
                        // Info Cards
                        VStack(spacing: 15) {
                            HStack(spacing: 15) {
                                InfoCard(title: "Active", value: "10.8kW")
                                InfoCard(title: "Last quarter", value: "$157.50")
                            }
                            HStack(spacing: 15) {
                                InfoCard(title: "Total savings", value: "$2,679.45")
                                InfoCard(title: "This quarter to date", value: "$52.50")
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
                                            .fill(Color("AccentColour3"))
                                            .frame(width: 100, height: 100)

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
                            

                            Divider()
                                .background(Color.yellow)

                            Text("To eliminate your Electricity Bill visit our ")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            +
                            Text("website")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .underline()
                            +
                            Text(" to update your SolarCloud portfolio.")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(20)
                    .padding(.horizontal)

                    // MARK: - Active Panels Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("My active panels")
                            .font(.title3)
                            .foregroundColor(.white)

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
}


struct InfoCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom("Poppins", size: 10))
                .foregroundColor(.gray)

            Text(value)
                .font(.headline)
                .foregroundColor(Color("AccentColor2")) // use yellow if preferred
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("backgroundColour")) // dark color
        .cornerRadius(12)
    }
}

#Preview {
    ActiveDashboardView()
}
