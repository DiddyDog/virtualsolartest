import SwiftUI
import FirebaseAuth

struct MoreView: View {
    enum SettingOption: String, CaseIterable, Identifiable {
        case myDetails = "My Details"
        case statement = "Statement"
        case progressTracker = "Progress Tracker"
        case allocations = "Allocations"
        case videoExplainer = "Video Explainer"
        case legalDocument = "Legal Document"
        case faq = "FAQ"
        case contactUs = "Contact Us"
        case logout = "Logout"

        var id: String { self.rawValue }
    }

    @State private var selectedOption: SettingOption?
    @State private var shouldNavigateToLogin = false
    @State private var showPopup = false
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        Image("SolarCloudLogo")
                            .resizable()
                            .frame(width: 28.86, height: 50.0)
                            .padding(.top)

                        HStack {
                            Image("UserIcon")
                                .foregroundColor(Color("AccentColor1"))
                                .fixedSize()
                                .frame(width: 8, height: 8)
                                .padding()
                            Text("Settings")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.horizontal)

                        VStack(spacing: 16) {
                            ForEach(SettingOption.allCases) { option in
                                NavigationLink(
                                    destination: destinationView(for: option),
                                    tag: option,
                                    selection: $selectedOption
                                ) {
                                    EmptyView()
                                }

                                Button(action: {
                                    handleOptionTap(option)
                                }) {
                                    HStack {
                                        Text(option.rawValue)
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white.opacity(1))
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.06))
                                    .cornerRadius(12)
                                }
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(24)
                        .padding(.horizontal)

                        NavigationLink(destination: LoginView(), isActive: $shouldNavigateToLogin) {
                            EmptyView()
                        }
                    }
                }

                // ✅ Success Popup
                if showPopup {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            VStack(spacing: 10) {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.green)
                                    .scaleEffect(showPopup ? 1.2 : 0.8)
                                    .animation(.easeInOut(duration: 0.3), value: showPopup)

                                Text("Profile updated!")
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(radius: 8)
                            .transition(.scale.combined(with: .opacity))
                            Spacer()
                        }
                        Spacer()
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showPopup = false
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Navigation destinations
    @ViewBuilder
    func destinationView(for option: SettingOption) -> some View {
        switch option {
        case .myDetails:
            MyDetailsView(showUpdatePopup: $showPopup)
        case .statement:
            StatementView()
        case .progressTracker:
            ProgressTrackerView()
        case .allocations:
            AllocationsHomeView()
        case .videoExplainer:
            VideoExplainerView()
        case .legalDocument:
            LegalDocumentView()
        case .faq:
            FAQView()
        case .contactUs:
            ContactUsView()
        case .logout:
            EmptyView()
        }
    }

    // MARK: - Action Handler
    func handleOptionTap(_ option: SettingOption) {
        if option == .logout {
            do {
                try Auth.auth().signOut()
                shouldNavigateToLogin = true
                print("✅ Logged out")
                appState.isLoggedIn = false
            } catch {
                print("❌ Logout failed: \(error.localizedDescription)")
            }
        } else {
            selectedOption = option
        }
    }
}
