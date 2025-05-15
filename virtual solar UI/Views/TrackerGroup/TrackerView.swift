import SwiftUI
import FirebaseCore

struct TrackerView: View {
    // Local placeholders for Active and Pending (replace with dynamic data later)
    let activeKW: String = "5.8kW"
    let pendingKW: String = "6.2kW"
    let events = TimelineEvent.sampleData.sorted(by: { $0.date > $1.date})

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                //Logo
                VStack(spacing: 16) {
                    HStack {
                        Spacer()
                        Image("SolarCloudLogo")
                            .resizable()
                            .frame(width: 28.86, height: 50)
                        Spacer()
                    }
                    .padding(.top, 20)


                    ScrollView { // Showing the full timeline view and contents of the tracker
                        HStack(spacing: 8) {
                            Image("ListIcon")
                                .foregroundColor(Color("AccentColor1"))
                            Text("Tracker")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 24))
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            // Active and Pending headings with kW values
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
                                
                                // Divider line under active and pending headings
                                Divider()
                                    .frame(height: 1)
                                    .background(Color.gray.opacity(0.5))
                                    .padding(.top, 15)
                                    .padding(.leading, 120)
                                    .padding(.trailing, 120)
                            }
                            
                            // Timeline view
                            TimelineView(events: events)
                                .padding(.top, 8)
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
