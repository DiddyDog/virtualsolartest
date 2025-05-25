import SwiftUI
import Firebase
import FirebaseFirestore

struct PendingDashboardView: View {
    @State private var billAmount: String = ""
    @State private var navigateToCalculator = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // No pending info card
                PendingInfoCard()

                // Calculator Section
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 10) {
                        Image(systemName: "list.bullet.rectangle")
                            .foregroundColor(.mint)
                        Text("Calculator")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Find out your solar savings")
                            .foregroundColor(.white)
                            .font(.headline)

                        Text("Enter in your Electricity Bill")
                            .foregroundColor(.white)

                        TextField("$...", text: $billAmount)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(10)

                        NavigationLink(
                            destination: CalculatorView(initialBillAmount: billAmount),
                            isActive: $navigateToCalculator
                        ) {
                            EmptyView()
                        }


                        Button(action: {
                            navigateToCalculator = true
                        }) {
                            Text("Calculate")
                                .foregroundColor(.black)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("AccentColor2"))
                                .cornerRadius(30)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(20)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
            .background(Color("BackgroundColor").ignoresSafeArea())
        }
    }
}

struct TabButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(isSelected ? Color.mint.opacity(0.3) : Color.clear)
                .foregroundColor(isSelected ? .mint : .white.opacity(0.6))
                .cornerRadius(8)
                .frame(width: 140)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.mint, lineWidth: isSelected ? 1.8 : 1)
                )
        }
    }
}

struct PendingInfoCard: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("You currently have no pending panels.")
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.white)

            Group {
                Text("Visit our ") +
                Text("website").underline() +
                Text(" to see available panels")
            }
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .foregroundColor(.white.opacity(0.8))

            Button(action: {
                // Add action if needed
            }) {
                Text("Take me there")
                    .foregroundColor(.black)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("AccentColor2"))
                    .cornerRadius(30)
                    .frame(width: 160)
            }
            .padding(.top, 8)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.4))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}
#Preview{
    PendingDashboardView()
}
