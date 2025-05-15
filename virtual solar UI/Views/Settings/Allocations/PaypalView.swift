import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct PaypalView: View {
    @Environment(\.dismiss) var dismiss

    @State private var allocatedPanels = 0
    @State private var leftPanels = 6
    @State private var totalPanels = 6

    @State private var selectedPanels = 1
    @State private var email = ""
    @State private var nickname = ""

    @State private var emailError = false
    @State private var nicknameError = false

    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()

            VStack(spacing: 20) {
                // Logo
                HStack {
                    Spacer()
                    Image("SolarCloudLogo")
                        .resizable()
                        .frame(width: 28.86, height: 50)
                    Spacer()
                }

                // Title + Back
                HStack(spacing: 10) {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("AccentColor2"))
                    }

                    Text("Paypal account")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal)

                // Description
                Text("Enter your Paypal email where your wish to see your disbursements appear")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Allocated Panels
                HStack {
                    Spacer()
                    VStack {
                        Text("allocated")
                            .font(.caption)
                            .foregroundColor(.gray)
                        VStack {
                            Text("\(allocatedPanels) panels")
                                .foregroundColor(Color("AccentColor2"))
                            Text("\(String(format: "%.1f", Double(allocatedPanels) * 0.85))kW")
                                .font(.caption2)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color("AccentColor3"))
                        .cornerRadius(16)
                    }
                    Spacer()
                    VStack {
                        Text("left")
                            .font(.caption)
                            .foregroundColor(.gray)
                        VStack {
                            Text("\(leftPanels) panels")
                                .foregroundColor(Color("AccentColor2"))
                            Text("\(String(format: "%.1f", Double(leftPanels) * 0.85))kW")
                                .font(.caption2)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color("AccentColor3"))
                        .cornerRadius(16)
                    }
                    Spacer()
                }

                // Panel Selector
                VStack(spacing: 4) {
                    Text("Panels")
                        .foregroundColor(.white)

                    HStack(spacing: 0) {
                        Button {
                            if selectedPanels > 1 { selectedPanels -= 1 }
                        } label: {
                            Text("–")
                                .font(.title2)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .background(Color("AccentColor3"))
                        }

                        Text("\(selectedPanels)")
                            .frame(width: 60, height: 40)
                            .background(Color("AccentColor3"))
                            .foregroundColor(.white)

                        Button {
                            if selectedPanels < leftPanels { selectedPanels += 1 }
                        } label: {
                            Text("+")
                                .font(.title2)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .background(Color("AccentColor3"))
                        }
                    }
                    .cornerRadius(12)
                }

                // Fields
                VStack(alignment: .leading, spacing: 2) {
                    Text("Paypal email")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Enter your PayPal email", text: $email)
                        .padding()
                        .background(emailError ? Color.red.opacity(0.2) : Color("AccentColor3"))
                        .cornerRadius(10)
                        .foregroundColor(.white)

                    if emailError {
                        Text("Email is required")
                            .font(.caption2)
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Nickname")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Enter nickname", text: $nickname)
                        .padding()
                        .background(nicknameError ? Color.red.opacity(0.2) : Color("AccentColor3"))
                        .cornerRadius(10)
                        .foregroundColor(.white)

                    if nicknameError {
                        Text("Nickname is required")
                            .font(.caption2)
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)

                // Add Button
                Button(action: handleAdd) {
                    Text("Add")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("AccentColor2"))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
        }
        .onAppear(perform: fetchAllocations)
        .navigationBarBackButtonHidden(true)
    }

    func handleAdd() {
        emailError = email.trimmingCharacters(in: .whitespaces).isEmpty
        nicknameError = nickname.trimmingCharacters(in: .whitespaces).isEmpty

        guard !emailError && !nicknameError else { return }

        let data: [String: Any] = [
            "email": email,
            "nickname": nickname,
            "allocatedPanels": selectedPanels,
            "kilowatt": Double(selectedPanels) * 0.85
        ]

        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("paypalAllocations")
            .addDocument(data: data) { error in
                if error == nil {
                    print("✅ PayPal info saved successfully")
                    dismiss()
                }
            }
    }

    func fetchAllocations() {
        allocatedPanels = 0
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let group = DispatchGroup()

        group.enter()
        db.collection("users").document(uid).collection("energyBills").getDocuments { snapshot, error in
            if let docs = snapshot?.documents {
                for doc in docs {
                    allocatedPanels += doc.data()["allocatedPanels"] as? Int ?? 0
                }
            }
            group.leave()
        }

        group.enter()
        db.collection("users").document(uid).collection("paypalAllocations").getDocuments { snapshot, error in
            if let docs = snapshot?.documents {
                for doc in docs {
                    allocatedPanels += doc.data()["allocatedPanels"] as? Int ?? 0
                }
            }
            group.leave()
        }

        group.enter()
        db.collection("users").document(uid).collection("bankAccounts").getDocuments { snapshot, error in
            if let docs = snapshot?.documents {
                for doc in docs {
                    allocatedPanels += doc.data()["allocatedPanels"] as? Int ?? 0
                }
            }
            group.leave()
        }

        group.notify(queue: .main) {
            leftPanels = max(0, totalPanels - allocatedPanels)
        }
    }
}
#Preview {
    PaypalView()
}
