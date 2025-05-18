import SwiftUI

struct NotificationContentView: View {
    let event: TimelineEvent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) { // Consistent spacing
            Divider()
                .frame(height: 1)
                .background(Color.gray)
                .padding(.leading, 0)
                .padding(.trailing, 60)
                .padding(.bottom, 4)
            
            Text(event.title)
                .font(.custom("Poppins-SemiBold", size: 24))
                .foregroundColor(.white)
            
            if let amount = event.amount {
                Text(String(format: "$%.2f", amount))
                    .font(.custom("Poppins-SemiBold", size: 24))
                    .foregroundColor(event.type == .Payments ? Color("AccentColor2") : Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading) // Ensure alignment
            }
            
            Text(event.description)
                .font(.custom("Poppins", size: 16))
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12) // Consistent padding
        .frame(maxWidth: .infinity, minHeight: 70, alignment: .leading) // Ensure alignment
        .background(Color("CardBackground"))
    }
}
