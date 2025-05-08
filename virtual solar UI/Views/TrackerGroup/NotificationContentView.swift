import SwiftUI

struct NotificationContentView: View {
    let event: TimelineEvent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(event.title)
                    .font(.custom("Poppins-SemiBold", size: 16))
                    .foregroundColor(.white)
                
                Spacer()
                
                if let amount = event.amount {
                    Text(String(format: "$%.2f", amount))
                        .font(.custom("Poppins-SemiBold", size: 14))
                        .foregroundColor(event.type == .payout ? Color.green : Color.white)
                }
            }
            
            Text(event.description)
                .font(.custom("Poppins", size: 14))
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(Color("CardBackground"))
        .cornerRadius(8)
    }
}
