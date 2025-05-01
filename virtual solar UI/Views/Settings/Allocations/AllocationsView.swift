import SwiftUI

struct AllocationsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                VStack(spacing: 20) {
                    Image("SolarCloudLogo")
                        .resizable()
                        .frame(width: 28.86, height: 50)

                    // Custom Back Button and Title
                    HStack(spacing: 10) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("AccentColor2"))
                        }

                        Text("Payouts / Allocations")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Spacer()
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Step 1.")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.white)

                        Text("Select an account where you wish the money from your virtual solar to magically appear")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    VStack(spacing: 16) {
                        NavigationLink(destination: EnergyBillView()) {
                            AllocationButton(title: "Energy bill", colorName: "AccentColor2")
                        }

                        NavigationLink(destination: PaypalView()) {
                            AllocationButton(title: "Paypal / Mint", colorName: "AccentColor2")
                        }

                        NavigationLink(destination: EFTView()) {
                            AllocationButton(title: "EFT", colorName: "AccentColor2")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    Spacer()
                }
                .padding(.top)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct AllocationButton: View {
    var title: String
    var colorName: String = "AccentColor2"

    var body: some View {
        HStack(spacing: 14) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .background(Color(colorName))
        .cornerRadius(16)
        .shadow(color: Color(colorName).opacity(0.3), radius: 6, x: 0, y: 4)
    }
}
#Preview {
    AllocationsView()
}
