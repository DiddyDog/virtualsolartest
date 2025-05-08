import SwiftUI
import FirebaseCore

struct TrackerView: View {
    // Local placeholders (replace with dynamic data later)
    let activeKW: String = "5.8kW"
    let pendingKW: String = "6.2kW"
    let events = TimelineEvent.sampleData.sorted(by: { $0.date > $1.date})

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(spacing: 16) {
                    // Top center logo
                    HStack {
                        Spacer()
                        Image("SolarCloudLogo")
                            .resizable()
                            .frame(width: 28.86, height: 50)
                        Spacer()
                    }
                    .padding(.top, 20)

                    // Left-aligned icon and text
                    HStack(spacing: 8) {
                        Image("ListIcon")
                            .foregroundColor(Color("AccentColor1"))
                        Text("Tracker")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 24))
                        Spacer()
                    }
                    .padding(.horizontal)

                    // "Active" and "Pending" headings with kW values
                    VStack(spacing: 4) {
                        HStack {
                            Spacer()
                            VStack(spacing: 2) {
                                Text("Active")
                                    .font(.custom("Poppins-SemiBold", size: 14))
                                    .foregroundColor(.white)
                                Text(activeKW) // <-- Using local variable
                                    .font(.custom("Poppins", size: 14))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            VStack(spacing: 2) {
                                Text("Pending")
                                    .font(.custom("Poppins-SemiBold", size: 14))
                                    .foregroundColor(.white)
                                Text(pendingKW) // <-- Using local variable
                                    .font(.custom("Poppins", size: 14))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        
                        // Divider under both headings
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray.opacity(0.5))
                            .padding(.top, 15)
                            .padding(.leading, 120)
                            .padding(.trailing, 120)
                    }
                    
                    TimelineView(events: events)
                        .padding(.top, 8)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    TrackerView()
}
