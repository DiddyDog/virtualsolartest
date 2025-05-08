import SwiftUI

struct DateBoxView: View {
    let date: Date
    
    var body: some View {
        VStack(spacing: 2) {
            Text(monthString)
                .font(.custom("Poppins-SemiBold", size: 12))
                .foregroundColor(.white)
            Text(dayString)
                .font(.custom("Poppins-SemiBold", size: 18))
                .foregroundColor(.white)
            Text(yearString)
                .font(.custom("Poppins", size: 10))
                .foregroundColor(.gray)
        }
        .frame(width: 60, height: 60)
        .background(Color("AccentColor1").opacity(0.8))
        .cornerRadius(8)
    }
    
    private var monthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: date).uppercased()
    }
    
    private var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
    
    private var yearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }
}
