import SwiftUI

struct AllocationsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showOptions = false

    // Navigation states
    @State private var goToBank = false
    @State private var goToEnergy = false
    @State private var goToPaypal = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                VStack(spacing: 20) {
                    // Centered Logo
                    HStack {
                        Spacer()
                        Image("SolarCloudLogo")
                            .resizable()
                            .frame(width: 28.86, height: 50)
                        Spacer()
                    }

                    // Title + Back Button
                    HStack(spacing: 10) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("AccentColor2"))
                        }

                        Text("Payouts / Allocations")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Spacer()
                    }
                    .padding(.horizontal)

                    // Subheading
                    Text("Select an account where you wish the money from your virtual solar to magically appear")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    // YOU HAVE
                    Text("You have")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()

                    // Pending
                    VStack(spacing: 4) {
                        Text("almost there")
                            .foregroundColor(.gray)
                            .font(.caption)

                        HStack {
                            Text("Pending")
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                            Text("5.1kW/6 panels")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color("AccentColor3"))
                        .cornerRadius(20)
                        .frame(width: 245, height: 55.48)
                    }
                    .padding(.horizontal)

                    Divider()
                        .overlay(Color("AccentColor2"))
                        .frame(width: 230)

                    // Active
                    VStack(spacing: 4) {
                        Text("to allocate")
                            .foregroundColor(.white)
                            .font(.caption)

                        HStack {
                            Text("Active")
                                .bold()
                                .foregroundColor(.black)
                            Spacer()
                            Text("5.1kW/6 panels")
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color("AccentColor2"))
                        .cornerRadius(20)
                        .frame(width: 245, height: 55.48)
                    }
                    .padding(.horizontal)

                    // Dropdown button
                    Button {
                        withAnimation {
                            showOptions.toggle()
                        }
                    } label: {
                        HStack {
                            Text("payee allocation")
                                .foregroundColor(Color("AccentColor2"))
                            Spacer()
                            Image(systemName: showOptions ? "chevron.up" : "chevron.down")
                                .foregroundColor(Color("AccentColor2"))
                        }
                        .padding()
                        .background(Color("AccentColor3"))
                        .cornerRadius(20)
                        .shadow(radius: 6)
                        .frame(width: 250)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)

                    // Dropdown Options
                    if showOptions {
                        VStack(spacing: 0) {
                            Button(action: {
                                goToBank = true
                                showOptions = false
                            }) {
                                Text("Bank")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .foregroundColor(.white)
                            }
                            Divider().background(Color("AccentColor2"))

                            Button(action: {
                                goToEnergy = true
                                showOptions = false
                            }) {
                                Text("Energy Company")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .foregroundColor(Color("AccentColor2"))
                            }
                            Divider().background(Color("AccentColor2"))

                            Button(action: {
                                goToPaypal = true
                                showOptions = false
                            }) {
                                Text("PayPal")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .foregroundColor(.white)
                            }
                        }
                        .background(Color("AccentColor5"))
                        .cornerRadius(30)
                        .padding(.horizontal, 0)
                        .padding(.top, 10)
                        .transition(.move(edge: .bottom))
                    }

                    Spacer()
                }
                .padding(.top)
            }

            // ✅ Navigation destinations
            .navigationDestination(isPresented: $goToBank) {
                EFTView()
            }
            .navigationDestination(isPresented: $goToEnergy) {
                EnergyBillView()
            }
            .navigationDestination(isPresented: $goToPaypal) {
                PaypalView()
            }

            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    AllocationsView()
}
