import Foundation

struct TimelineEvent: Identifiable {
    let id = UUID()
    let date: Date
    let title: String
    let description: String
    let type: NotificationType
    let amount: Double?
    
}

// Sample data for preview
extension TimelineEvent {
    static let sampleData: [TimelineEvent] = [
        TimelineEvent(
            date: Date().addingTimeInterval(-86400 * 30 * 5), // 5 months ago
            title: "System Purchase",
            description: "Purchased 12 solar panels",
            type: .purchase,
            amount: 670.50
        ),
        TimelineEvent(
            date: Date().addingTimeInterval(-86400 * 30 * 4), // 4 months ago
            title: "First Payout",
            description: "Received first energy credit payout",
            type: .payout,
            amount: 120.75
        ),
        TimelineEvent(
            date: Date().addingTimeInterval(-86400 * 30 * 3), // 3 months ago
            title: "System Update",
            description: "Firmware updated to v2.1.3",
            type: .systemUpdate,
            amount: nil
        ),
        TimelineEvent(
            date: Date().addingTimeInterval(-86400 * 30 * 2), // 2 months ago
            title: "Monthly Payout",
            description: "Energy credit for clear weather period",
            type: .payout,
            amount: 95.20
        ),
        TimelineEvent(
            date: Date().addingTimeInterval(-86400 * 14), // 2 weeks ago
            title: "Maintenance Check",
            description: "Annual system inspection completed",
            type: .maintenance,
            amount: nil
        )
    ]
}
