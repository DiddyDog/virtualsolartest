/*import SwiftUI
 
 struct TrackerView: View {
 let activeKW: String = "5.8kW"
 let pendingKW: String = "6.2kW"
 let events = TimelineEvent.sampleData.sorted(by: { $0.date > $1.date })
 
 // State
 @State private var isInformationPressed = false
 @State private var isTimeFramePressed = false
 @State private var selectedInformationFilter: String? = nil
 @State private var selectedTimeFrameFilter: String? = nil
 
 // Filter options
 private let informationFilters = [
 "Information",
 "Disbursement",
 "Reminders",
 "Require Actions",
 "Payments"
 ]
 private let timeFrameFilters = ["All", "Last Month", "Last 3 Months", "Last Year"]
 
 // Computed property for filtered events
 private var filteredEvents: [TimelineEvent] {
 let filtered = events
 // Apply filters here (same logic as before)
 return filtered
 }
 
 var body: some View {
 NavigationStack {
 ZStack {
 Color("BackgroundColor").ignoresSafeArea()
 VStack(spacing: 16) {
 // Header
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
 // Active/Pending Section
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
 
 // Filter Buttons
 VStack(spacing: 8) {
 HStack(spacing: 16) {
 FilterButton(
 title: "Information",
 isPressed: $isInformationPressed,
 action: {
 isInformationPressed.toggle()
 if isInformationPressed { isTimeFramePressed = false }
 }
 )
 .zIndex(2)
 
 FilterButton(
 title: "Time Frame",
 isPressed: $isTimeFramePressed,
 action: {
 isTimeFramePressed.toggle()
 if isTimeFramePressed { isInformationPressed = false }
 }
 )
 .zIndex(2)
 }
 
 
 
 
 // Dropdown Menus
 DropdownMenu(
 options: informationFilters,
 isVisible: $isInformationPressed,
 onSelect: { selectedInformationFilter = $0 }
 )
 
 
 
 DropdownMenu(
 options: timeFrameFilters,
 isVisible: $isTimeFramePressed,
 onSelect: { selectedTimeFrameFilter = $0 }
 )
 
 
 }
 .padding(.horizontal)
 
 
 // Timeline
 TimelineView(events: filteredEvents)
 .padding(.top, 1)
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
 */

import SwiftUI

struct TrackerView: View {
    let activeKW: String = "5.8kW"
    let pendingKW: String = "6.2kW"
    let events = TimelineEvent.sampleData.sorted(by: { $0.date > $1.date })
    
    @State private var selectedInformationFilter: String? = "All Info"
    @State private var selectedTimeFrameFilter: String? = "All Times"
    @State private var expandedDropdownID: String? = nil
    
    private let informationFilters = [
        "All Info",
        "Information",
        "Disbursement",
        "Reminders",
        "Require Actions",
        "Payments"
    ]
    
    private let timeFrameFilters = ["All Times", "Last Month", "Last 3 Months", "Last Year"]
    
    private var filteredEvents: [TimelineEvent] {
        var filtered = events
        
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
                // "Information" case or others
                filtered = filtered.filter { $0.type == .Information }
            }
        }
        
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
                    // Header
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
                            // Active/Pending Section
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
                            
                            // Dropdown Menus
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
                            
                            // Timeline
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
