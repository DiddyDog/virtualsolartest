/*import SwiftUI

struct FilterButton: View {
    let title: String
    @Binding var isPressed: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            HStack {
                Text(title)
                    .font(.custom("Poppins", size: 15))
                    .foregroundColor(isPressed ? Color("AccentColor2") : .white)
                Image(systemName: "chevron.down")
                    .foregroundColor(isPressed ? Color("AccentColor2") : .white)
                    .rotationEffect(.degrees(isPressed ? 180 : 0))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
        }
        .background(Color("AccentColor6"))
        .clipShape(Capsule())
        .offset(y: isPressed ? 20 : 0) // Moves the button down when pressed
        .animation(.easeInOut(duration: 0.2), value: isPressed)
        .zIndex(1)
    }
}
*/
