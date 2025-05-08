import SwiftUI

struct TimelineEventView: View {
    let event: TimelineEvent
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Date box with connecting line
            VStack(spacing: 0) {
                DateBoxView(date: event.date)
                
                // Connecting line
                Rectangle()
                    .frame(width: 2, height: 24)
                    .foregroundColor(Color("AccentColor1"))
                    .opacity(0.6)
            }
            
            // Notification content
            NotificationContentView(event: event)
            
            Spacer()
        }
    }
}
