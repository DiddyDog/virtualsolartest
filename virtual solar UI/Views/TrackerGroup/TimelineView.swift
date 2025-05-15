/*
import SwiftUI

struct TimelineView: View {
    let events: [TimelineEvent]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(events.enumerated()), id: \.element.id) { index, event in
                TimelineEventView(
                    event: event,
                    nextEventDate: index < events.count - 1 ? events[index + 1].date : nil
                )
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
*/

import SwiftUI

struct TimelineView: View {
    let events: [TimelineEvent]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(events.enumerated()), id: \.element.id) { index, event in
                TimelineEventView(
                    event: event,
                    nextEventDate: index < events.count - 1 ? events[index + 1].date : nil,
                    isFirst: index == 0,
                    isLast: index == events.count - 1
                )
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
