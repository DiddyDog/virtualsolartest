
//  Created by Abubakar Abbas on 5/3/2025.
//

import SwiftUI

struct OnBoardView: View {
    @State private var isActive = false
    @State private var opacity = 0.0
    
    var body: some View {
        NavigationStack {
            if isActive {
                LoginView() //replace with your main screen
            } else {
                ZStack {
                    ZStack {
                        //background gradient
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color("AccentColor4"), location: 0.0),  //top color
                                .init(color: Color("BackgroundColor"), location: 0.5),  //middle color
                                .init(color: Color("AccentColor4"), location: 1.0)   //bottom color
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()
                        
                        VStack {
                            //logo
                            Image("SolarCloudLogo") //Ensure you add this image to Assets
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .opacity(opacity)
                                .onAppear {
                                    withAnimation(.easeIn(duration: 1.5)) {
                                        opacity = 1.0
                                    }
                                }
                            
                            //app name
                            Text("SOLAR")
                                .font(.custom("Poppins", size: 28).weight(.bold)) // Poppins font for "SOLAR"
                                .foregroundColor(.yellow)
                            + Text("CLOUD")
                                .font(.custom("Poppins", size: 28).weight(.bold)) // Poppins font for "CLOUD"
                                .foregroundColor(.gray)
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isActive = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    struct OnBoardView_Previews: PreviewProvider {
        static var previews: some View {
            OnBoardView()
        }
    }
}

#Preview {
    OnBoardView()
}
