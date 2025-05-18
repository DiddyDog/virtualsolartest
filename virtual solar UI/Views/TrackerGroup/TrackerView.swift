import SwiftUI

// Main tracker screen: header, dropdown filters, and timeline of events
struct TrackerView: View {
    let activeKW: String = "5.8kW"
    let pendingKW: String = "6.2kW"
    let events = TimelineEvent.sampleData.sorted(by: { $0.date > $1.date })

    @State private var selectedInformationFilter: String? = "All Info"
    @State private var selectedTimeFrameFilter: String? = "All Times"
    @State private var expandedDropdownID: String? = nil

    // Dropdown options for information and time frame filters
    private let informationFilters = [
        "All Info",
        "Information",
        "Disbursement",
        "Reminders",
        "Require Actions",
        "Payments"
    ]
    private let timeFrameFilters = ["All Times", "Last Month", "Last 3 Months", "Last Year"]

    // Filters events based on selected filters
    private var filteredEvents: [TimelineEvent] {
        var filtered = events

        // Filter by information type
        if let infoFilter = selectedInformationFilter, infoFilter != "All Info" {
            switch infoFilter {
            case "Disbursement":
                filtered = filtered.filter { $0.type == .Disbursement }
            case "Reminders":
                filtered = filtered.filter { $0.type == .Reminders }
            case "Require Actions":
                filtered = filtered.filter { $0.type == .RequireActions }
            case "Payments":
                filtered = filtered.filter { $0.type == .Payments }
            default:
                filtered = filtered.filter { $0.type == .Information }
            }
        }

        // Filter by time frame
        if let timeFilter = selectedTimeFrameFilter {
            let now = Date()
            switch timeFilter {
            case "Last Month":
                filtered = filtered.filter { $0.date > now.addingTimeInterval(-30 * 86400) }
            case "Last 3 Months":
                filtered = filtered.filter { $0.date > now.addingTimeInterval(-90 * 86400) }
            case "Last Year":
                filtered = filtered.filter { $0.date > now.addingTimeInterval(-365 * 86400) }
            default: break
            }
        }

        return filtered
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                VStack(spacing: 16) {
                    // Header with logo
                    HStack {
                        Spacer()
                        Image("SolarCloudLogo")
                            .resizable()
                            .frame(width: 28.86, height: 50)
                        Spacer()
                    }
                    .padding(.top, 20)

                    ScrollView {
                        VStack(spacing: 16) {
                            // Active/Pending kW section
                            VStack(spacing: 4) {
                                HStack {
                                    Spacer()
                                    VStack(spacing: 2) {
                                        Text("Active")
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundColor(.white)
                                        Text(activeKW)
                                            .font(.custom("Poppins", size: 16))
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    VStack(spacing: 2) {
                                        Text("Pending")
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundColor(.white)
                                        Text(pendingKW)
                                            .font(.custom("Poppins", size: 16))
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                                Divider()
                                    .frame(height: 1)
                                    .background(Color.gray)
                                    .padding(.top, 15)
                                    .padding(.horizontal, 120)
                            }

                            // Dropdown filter menus
                            HStack(spacing: 8) {
                                DropdownMenu(
                                    options: informationFilters,
                                    selectedOption: $selectedInformationFilter,
                                    onSelect: { _ in },
                                    expandedID: $expandedDropdownID,
                                    id: "info",
                                    xOffset: 56,
                                    yOffset: 197
                                )
                                DropdownMenu(
                                    options: timeFrameFilters,
                                    selectedOption: $selectedTimeFrameFilter,
                                    onSelect: { _ in },
                                    expandedID: $expandedDropdownID,
                                    id: "time",
                                    xOffset: -56,
                                    yOffset: 146.5
                                )
                            }
                            .coordinateSpace(name: "DropdownSpace")
                            .zIndex(1)
                            .padding(.horizontal)
                            .fixedSize(horizontal: false, vertical: true)

                            // Timeline of filtered events
                            TimelineView(events: filteredEvents)
                                .padding(.top, 1)
                                .padding(.horizontal, 1)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
            }
        }
    }
}

#Preview {
    TrackerView()
}
