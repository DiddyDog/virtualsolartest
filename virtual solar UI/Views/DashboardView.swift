import SwiftUI
import FirebaseAuth

struct DashboardView: View {
    @State private var isLoggedOut = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                VStack {
                    // Header with logo and logout
                    HStack {
                        Image("SolarCloudLogo")
                            .resizable()
                            .frame(width: 28.86, height: 50.0)

                        Spacer()

                        Button(action: logout) {
                            Text("Logout")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

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

                        VStack(spacing: 12) {
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
                    .padding(.bottom, 20)
                }

                // 🔁 Optional: Navigate to Login screen if logged out
                NavigationLink(destination: LoginView(), isActive: $isLoggedOut) {
                    EmptyView()
                }
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedOut = true
        } catch let error {
            print("❌ Error signing out: \(error.localizedDescription)")
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
