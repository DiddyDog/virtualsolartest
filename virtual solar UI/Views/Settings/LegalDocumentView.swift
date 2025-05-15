import SwiftUI

struct LegalDocumentView: View {
    @Environment(\.dismiss) var dismiss  // ✅ to dismiss the screen

    let items = [
        "Balance receipt 21/08/2021",
        "Deposit 08/08/2021",
        "Balance receipt 21/06/2021",
        "Deposit 08/06/2021",
        "Replacement PDS",
        "Management Agreement",
        "Constitution",
        "Indicative Return"
    ]

    var body: some View {
        NavigationStack {  // ✅ Updated to NavigationStack
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                VStack(spacing: 20) {
                    // Logo
                    Image("SolarCloudLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 60)
                        .padding(.bottom, 10)

                    // Custom Back + Title
                    HStack {
                        Button(action: {
                            dismiss()  // ✅ now it will properly go back
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("AccentColor2"))
                                .font(.title2)
                        }
                        
                        Text("Paperwork")
                            .foregroundColor(.white)
                            .font(.title2.bold())
                        
                        Spacer()
                    }
                    .padding(.horizontal)

                    // Paperwork List
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(items, id: \.self) { item in
                                Button(action: {
                                    print("Tapped on \(item)")
                                }) {
                                    Text(item)
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color("AccentColor2"))
                                        .cornerRadius(10)
                                }
                            }

                            // Scroll For More Button
                            Button(action: {
                                print("Scroll for more tapped")
                            }) {
                                Text("scroll for more")
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("AccentColor2"))
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                    }

                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)  // ✅ hides default system back button
        }
    }
}

#Preview {
    LegalDocumentView()
}
