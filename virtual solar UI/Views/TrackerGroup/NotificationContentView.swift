import SwiftUI

struct NotificationContentView: View {
    let event: TimelineEvent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) { // Consistent spacing
            Text(event.title)
                .font(.custom("Poppins-SemiBold", size: 16))
                .foregroundColor(.white)
                .lineLimit(1) // Prevent title from wrapping
            
            if let amount = event.amount {
                Text(String(format: "$%.2f", amount))
                    .font(.custom("Poppins-SemiBold", size: 14))
                    .foregroundColor(event.type == .payout ? Color.green : Color.white)
            }
            
            Text(event.description)
                .font(.custom("Poppins", size: 14))
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12) // Consistent padding
        .frame(maxWidth: .infinity, minHeight: 70) // Minimum height to match DateBox
        .background(Color("CardBackground"))
        .cornerRadius(8)
    }
}
