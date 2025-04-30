import SwiftUI

struct StatementEntry: Identifiable {
    let id = UUID()
    let date: String
    let amount: Double
}

struct PanelGroup: Identifiable {
    let id = UUID()
    let name: String
    let panelCount: Int
    let entries: [StatementEntry]
}

struct StatementView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isExpanded: [UUID: Bool] = [:]
    @State private var selectedPanelName: String = "All"
    @State private var showDropdown = false

    let generalEntries: [StatementEntry] = [
        .init(date: "7 July 2021", amount: 1234),
        .init(date: "7 June 2021", amount: 1234),
        .init(date: "7 May 2021", amount: 1234),
        .init(date: "7 April 2021", amount: 1234)
    ]

    let panelGroups: [PanelGroup] = [
        .init(name: "Apartment", panelCount: 5, entries: [.init(date: "7 July 2021", amount: 134)]),
        .init(name: "Business 1", panelCount: 45, entries: [.init(date: "7 July 2021", amount: 960)]),
        .init(name: "Business 2", panelCount: 50, entries: [.init(date: "7 July 2021", amount: 98)])
    ]

    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()

            VStack(spacing: 20) {
                // Logo
                Image("SolarCloudLogo")
                    .resizable()
                    .frame(width: 28.86, height: 50)

                // Header with back button
                HStack(spacing: 10) {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("AccentColor2"))
                    }

                    Text("Statement")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal)

                // Card container
                VStack(alignment: .leading, spacing: 16) {
                    // Dropdown Selector
                    VStack(alignment: .leading, spacing: 6) {
                        Button {
                            withAnimation {
                                showDropdown.toggle()
                            }
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("AccentColor3"))
                                .frame(height: 50)
                                .overlay(
                                    HStack {
                                        Text(selectedPanelName)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(.leading)
                                        Spacer()
                                        Image(systemName: showDropdown ? "chevron.up" : "chevron.down")
                                            .foregroundColor(.white)
                                            .padding(.trailing)
                                    }
                                )
                        }

                        if showDropdown {
                            VStack(spacing: 6) {
                                Button(action: {
                                    selectedPanelName = "All"
                                    showDropdown = false
                                }) {
                                    Text("All")
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color("AccentColor3"))
                                        .cornerRadius(8)
                                }

                                ForEach(panelGroups) { group in
                                    Button(action: {
                                        selectedPanelName = group.name
                                        showDropdown = false
                                    }) {
                                        Text(group.name)
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(Color("AccentColor3"))
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .transition(.opacity.combined(with: .move(edge: .top)))
                        }
                    }
                    .padding(.bottom, 16)

                    // Entries
                    if selectedPanelName == "All" {
                        ForEach(generalEntries) { entry in
                            entryRow(entry)
                        }

                        ForEach(panelGroups) { group in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("\(group.name) \(group.panelCount) panels")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: isExpanded[group.id] ?? false ? "chevron.up" : "chevron.down")
                                        .foregroundColor(.white)
                                }
                                .onTapGesture {
                                    withAnimation {
                                        isExpanded[group.id] = !(isExpanded[group.id] ?? false)
                                    }
                                }

                                if isExpanded[group.id] ?? false {
                                    ForEach(group.entries) { entry in
                                        entryRow(entry)
                                    }
                                }
                            }
                        }
                    } else {
                        if let group = panelGroups.first(where: { $0.name == selectedPanelName }) {
                            Text("\(group.name) \(group.panelCount) panels")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            ForEach(group.entries) { entry in
                                entryRow(entry)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(20)
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
        }
        .onAppear {
            for group in panelGroups {
                isExpanded[group.id] = false
            }
        }
        .navigationBarBackButtonHidden(true) // ✅ Hide top system back button
    }

    // MARK: - Entry UI
    func entryRow(_ entry: StatementEntry) -> some View {
        HStack {
            Capsule()
                .fill(Color("AccentColor1"))
                .frame(width: 6, height: 28)

            Text(entry.date)
                .foregroundColor(.white)
                .font(.subheadline)

            Spacer()

            Text(String(format: "$%.2f", entry.amount))
                .foregroundColor(Color("AccentColor1"))
                .fontWeight(.semibold)
        }
        .padding()
        .background(Color("AccentColor3"))
        .cornerRadius(10)
    }
}

#Preview {
    StatementView()
}
