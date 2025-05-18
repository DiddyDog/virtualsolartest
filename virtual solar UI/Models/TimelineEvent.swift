import Foundation

/*struct TimelineEvent: Identifiable {
    let id = UUID()
    let date: Date
    let title: String
    let description: String
    let type: NotificationType
    let amount: Double?
    
}*/

struct TimelineEvent: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let title: String
    let description: String
    let type: NotificationType
    let amount: Double?
    
    static func == (lhs: TimelineEvent, rhs: TimelineEvent) -> Bool {
        lhs.id == rhs.id
    }
}

// Sample data for preview
extension TimelineEvent {
    static let sampleData: [TimelineEvent] = [
        TimelineEvent(
            date: Date().addingTimeInterval(-86400 * 30 * 5), // 5 months ago
            title: "Payment due in 15 days",
            description: "90% of total order amount due, 10 panels, 1kW, 20yr guarantee",
            type: .Reminders,
            amount: 670.50
        ),
        TimelineEvent(
            date: Date().addingTimeInterval(-86400 * 30 * 4), // 4 months ago
            title: "First Payout",
            description: "Received first energy credit payout",
            type: .Payments,
            amount: 120.75
        ),
        TimelineEvent(
            date: Date().addingTimeInterval(-86400 * 30 * 3), // 3 months ago
            title: "System Update",
            description: "Alright gamers, I hear all this talk about Avengers Endgame being the best Marvel movie, and even if that has the case (It has Game in the title instant 10/10), it doesn't sit right with me with how Gamers are portrayed in this film. As you all know, Thor became a gamer along with the rest of the male cast of Thor Ragnork. (This is accurate.) Korg is still a baby gamer however and is being p%ned ™ by a member of the noob slayers, identification number 69. Korg then goes to his KING ,Thor, and cries about how he's being p%ned by a 12 yr old child (the age of Gaming puberty). Thor then threatens this noob slayer which is common Gamer tradition however he brings his IRL (In Real Life) status into the mix. (This is inaccurate.) Now while Gamers do hold powerful positions both in-game and IRL, we are also oppressed people. And true Gamers, that this so called Gamer King Thor is clearly not by this example alone, would not use his IRL status and power to oppress a fellow gamer. This is showing Gamers in a negative way and its being reflected in social media. The news is still sprouting nonsense that video games make gamers into shooters, and while they do give us the neccessary skills, they do not make us violent. This is all a ploy to oppress us Gamers even more and I for one will not take this sitting down. (insert gun emoji)",
            type: .Information,
            amount: nil
        ),
        TimelineEvent(
            date: Date().addingTimeInterval(-86400 * 30 * 2), // 2 months ago
            title: "Monthly Payout",
            description: "Energy credit for clear weather period",
            type: .Disbursement,
            amount: 95.20
        ),
        TimelineEvent(
            date: Date().addingTimeInterval(-86400 * 14), // 2 weeks ago
            title: "Add your allocations",
            description: "You can allocate your panels to your home and/or apartment so when your virtual panels are active you are ready to rock and roll",
            type: .RequireActions,
            amount: nil
        )
    ]
}

/*
 import SwiftUI

 struct TimelineEventView: View {
     let event: TimelineEvent
     let nextEventDate: Date?
     
     @State private var dateBoxHeight: CGFloat = 70
     @State private var contentHeight: CGFloat = 60 // Default initial height
     
     var body: some View {
         HStack(alignment: .top, spacing: 8) {
             // Date box with connecting line
             VStack(spacing: 0) {
                 DateBoxView(date: event.date)
                     .background(
                         GeometryReader { geo in
                             Color.clear
                                 .onAppear { dateBoxHeight = geo.size.height }
                                 .onChange(of: geo.size.height) { _ in
                                     dateBoxHeight = geo.size.height
                                 }
                         }
                     )
                 
                 if nextEventDate != nil {
                     Rectangle()
                         .frame(width: 2, height: lineHeight)
                         .foregroundColor(Color("AccentColor1"))
                         .animation(.default, value: lineHeight) // Smooth height changes
                 }
             }
             
             NotificationContentView(event: event)
                 .background(
                     GeometryReader { geo in
                         Color.clear
                             .onAppear {
                                 contentHeight = geo.size.height
                             }
                             .onChange(of: geo.size.height) { _ in
                                 contentHeight = geo.size.height
                             }
                     }
                 )
         }
     }
     
     private var lineHeight: CGFloat {
         let fixedHeight: CGFloat = 80 // Fixed height for the line
         let calculatedHeight = contentHeight - dateBoxHeight + 8 // Adjust based on content
         return max(fixedHeight, calculatedHeight) // Use the larger of the two
     }
 }

 */
