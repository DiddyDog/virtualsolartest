import SwiftUI

struct CalculatorView: View {
    var initialBillAmount: String = "450"

    @State private var billAmount: String = ""

    var billValue: Double {
        Double(billAmount) ?? 0
    }

    var solarPayout: Double {
        250
    }

    var savingPercent: Double {
        guard billValue > 0 else { return 0 }
        return min(solarPayout / billValue, 1.0)
    }

    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    // Logo & Title
                    VStack(spacing: 8) {
                        Image("SolarCloudLogo")
                            .resizable()
                            .frame(width: 28.86, height: 50.0)
                            .padding(.top, 1)

                        HStack {
                            Image("CalculatorIcon")
                                .foregroundColor(Color("AccentColor1"))
                                .fixedSize()
                                .frame(width: 8, height: 8)
                                .padding()
                            Text("Calculator")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }

                    // Input Card
                    VStack(spacing: 12) {
                        Text("Find out your solar savings")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)

                        Text("Enter your Electricity Bill")
                            .foregroundColor(.gray)

                        TextField("450", text: $billAmount)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color("CardBackgroundColor"))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.2)))
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(20)

                    // Solar Saving Info
                    Text("Solar saving\n$250/month*")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)

                    // Savings Grid
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 16) {
                        SavingsBox(label: "This month", amount: "$234")
                        SavingsBox(label: "Last month", amount: "$234")
                        SavingsBox(label: "Last 3 months", amount: "$234")
                        SavingsBox(label: "Last 6 months", amount: "$234")
                    }

                    // Chart + Summary
                    HStack(alignment: .center, spacing: 24) {
                        ZStack {
                            Circle()
                                .trim(from: 0, to: savingPercent)
                                .stroke(Color("AccentColor1"), lineWidth: 10)
                                .rotationEffect(.degrees(-90))
                                .animation(.easeInOut(duration: 0.4), value: savingPercent)

                            Text("\(Int(savingPercent * 100))% \nsaving")
                                .font(.caption)
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                        .frame(width: 100, height: 100)

                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Electricity bill")
                                Spacer()
                                Text("$\(Int(billValue))")
                                    .bold()
                                    .foregroundColor(Color("AccentColor2"))
                            }
                            HStack {
                                Text("Solar payout")
                                Spacer()
                                Text("$\(Int(solarPayout))")
                                    .bold()
                                    .foregroundColor(Color("AccentColor2"))
                            }
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal)

                    Divider()
                        .frame(height: 1)
                        .background(Color.yellow.opacity(0.5))
                        .padding(.horizontal)

                    // Disclaimer
                    VStack(spacing: 6) {
                        (
                            Text("To eliminate your Electricity Bill visit our ")
                            + Text("website").underline().foregroundColor(.blue)
                            + Text(" to update your SolarCloud portfolio.")
                        )
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .multilineTextAlignment(.center)

                        Text("*Terms and conditions of savings If you rent or own an apartment or house, or you own business, SolarCloud works")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.top, 4)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
        .onAppear {
            billAmount = initialBillAmount
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SavingsBox: View {
    var label: String
    var amount: String

    var body: some View {
        VStack(spacing: 6) {
            Text(label)
                .font(.caption)
                .foregroundColor(.white)
            Text(amount)
                .font(.headline)
                .foregroundColor(Color("AccentColor2"))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    CalculatorView(initialBillAmount: "450")
}
