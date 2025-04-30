import SwiftUI

struct DashboardView: View {
    @State private var selectedTab: DashboardTab = .active

    enum DashboardTab {
        case active
        case pending
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 12) {
                        Image("SolarCloudLogo")
                            .resizable()
                            .frame(width: 28.86, height: 50)
                            .padding(.top, 64)

                        HStack(spacing: 8) {
                            Image(systemName: "calendar.badge.clock")
                                .foregroundColor(Color("AccentColor1"))
                            Text("Dashboard")
                                .foregroundColor(.white)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }

                    // Tab Switch
                    HStack(spacing: 0) {
                        Button(action: {
                            selectedTab = .active
                        }) {
                            Text("Active")
                                .font(.subheadline)
                                .foregroundColor(selectedTab == .active ? .white : .gray)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                                .background(selectedTab == .active ? Color("AccentColor1") : Color.clear)
                                .cornerRadius(8)
                        }

                        Button(action: {
                            selectedTab = .pending
                        }) {
                            Text("Pending")
                                .font(.subheadline)
                                .foregroundColor(selectedTab == .pending ? .white : .gray)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                                .background(selectedTab == .pending ? Color("AccentColor1") : Color.clear)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)

                    // Conditional Views
                    Group {
                        if selectedTab == .active {
                            ActiveDashboardView()
                        } else {
                            PendingDashboardView()
                        }
                    }

                    Spacer(minLength: 40)
                }
                .padding(.bottom, 50)
            }
            .background(Color("BackgroundColor"))
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    DashboardView()
}
