import SwiftUI

struct TimelineView: View {
    let events: [TimelineEvent]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(events) { event in
                    TimelineEventView(event: event)
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
}
