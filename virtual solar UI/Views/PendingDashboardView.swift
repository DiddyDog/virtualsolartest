import SwiftUI

struct PendingDashboardView: View {
    @State private var selectedTab: String = "Pending"
    @State private var billAmount: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // Header Section
            HeaderView(selectedTab: $selectedTab)

            Spacer()

            // No Pending Info Card
            PendingInfoCard()

            // Solar Savings Input Card
            SavingsInputCard(billAmount: $billAmount)

            Spacer()

            // Bottom Tab Bar
            BottomTabBarView()
        }
        .background(Color(red: 24/255, green: 26/255, blue: 36/255))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HeaderView: View {
    @Binding var selectedTab: String

    var body: some View {
        VStack(spacing: 16) {
            // Header Logo
            Image("solar_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.top, 20)

            // Title
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.mint)
                Text("My panels")
                    .foregroundColor(.white)
                    .font(.title3.bold())
                Spacer()
            }
            .padding(.horizontal)

            // Tab Switch
            HStack(spacing: 0) {
                TabButton(title: "Active", isSelected: selectedTab == "Active") {
                    selectedTab = "Active"
                }
                TabButton(title: "Pending", isSelected: selectedTab == "Pending") {
                    selectedTab = "Pending"
                }
            }
            .padding(.horizontal)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
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
        }
    }
}

struct PendingInfoCard: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("You currently\nhave no pending\npanels.")
                .multilineTextAlignment(.center)
                .font(.title2.bold())
                .foregroundColor(.white)

            Group {
                Text("Visit our ") +
                Text("website").underline() +
                Text(" to see\navailable panels")
            }
            .multilineTextAlignment(.center)
            .foregroundColor(.white.opacity(0.8))
            .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.4))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

struct SavingsInputCard: View {
    @Binding var billAmount: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Find out your solar\nsavings*")
                .foregroundColor(.white)
                .font(.title3.bold())

            Text("Enter in your Electricity Bill")
                .foregroundColor(.white)

            TextField("$...", text: $billAmount)
                .padding()
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.4))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

struct BottomTabBarView: View {
    var body: some View {
        HStack {
            BottomTabBarItem(icon: "calendar", title: "Dashboard", isSelected: true)
            BottomTabBarItem(icon: "doc.text", title: "Tracker")
            BottomTabBarItem(icon: "plus.slash.minus", title: "Calculator")
            BottomTabBarItem(icon: "person", title: "More")
        }
        .padding(.top)
        .padding(.bottom, 10)
        .background(Color.black.opacity(0.3))
        .font(.caption)
    }
}

struct BottomTabBarItem: View {
    var icon: String
    var title: String
    var isSelected: Bool = false

    var body: some View {
        VStack {
            Image(systemName: icon)
            Text(title)
        }
        .foregroundColor(isSelected ? .mint : .white)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PendingDashboardView()
}
