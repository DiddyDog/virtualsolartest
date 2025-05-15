import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct AllocationItem: Identifiable {
    let id: String
    let nickname: String
    let allocatedPanels: Int
    let kilowatt: Double
}

struct AllocationsHomeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var allocations: [AllocationItem] = []
    @State private var totalAllocated = 0
    @State private var totalLeft = 6 // Example total
    @State private var navigateToAddMore = false

    var totalPanels = 6

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Logo
                        HStack {
                            Spacer()
                            Image("SolarCloudLogo")
                                .resizable()
                                .frame(width: 28.86, height: 50)
                            Spacer()
                        }
                        .padding(.top)

                        // Title + Custom Back Button
                        HStack(spacing: 10) {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("AccentColor2"))
                            }

                            Text("Payouts / Allocations")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Spacer()
                        }
                        .padding(.horizontal)

                        // Allocated and Left Panels
                        HStack {
                            Spacer()

                            VStack {
                                Text("allocated")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                VStack {
                                    Text("\(totalAllocated) panels")
                                        .font(.subheadline)
                                        .foregroundColor(Color("AccentColor2"))
                                    Text("\(String(format: "%.1f", Double(totalAllocated) * 0.85))kW")
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
                                    Text("\(totalLeft) panels")
                                        .font(.subheadline)
                                        .foregroundColor(Color("AccentColor2"))
                                    Text("\(String(format: "%.1f", Double(totalLeft) * 0.85))kW")
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color("AccentColor3"))
                                .cornerRadius(16)
                            }

                            Spacer()
                        }

                        // List of Allocations
                        ForEach(allocations) { allocation in
                            VStack(spacing: 8) {
                                Text(allocation.nickname)
                                    .font(.headline)
                                    .foregroundColor(Color("AccentColor2"))

                                HStack {
                                    Spacer()

                                    VStack(spacing: 4) {
                                        Text("Last quarter")
                                            .font(.caption)
                                            .foregroundColor(.white)

                                        HStack(spacing: 20) {
                                            VStack {
                                                Text("last payout")
                                                    .font(.caption2)
                                                    .foregroundColor(.gray)
                                                Text("$200")
                                                    .foregroundColor(Color("AccentColor2"))
                                            }

                                            VStack {
                                                Text("Savings")
                                                    .font(.caption2)
                                                    .foregroundColor(.gray)
                                                Text("$40")
                                                    .foregroundColor(Color("AccentColor2"))
                                            }
                                        }
                                    }

                                    Spacer()
                                }
                                .padding()
                                .background(Color("AccentColor5"))
                                .cornerRadius(20)
                            }
                            .padding(.horizontal)
                        }

                        // Add or Buy More button
                        Button(action: {
                            if totalLeft > 0 {
                                navigateToAddMore = true
                            } else {
                                // Buy more logic (empty for now)
                            }
                        }) {
                            Text(totalLeft > 0 ? "Add" : "Buy more")
                                .fontWeight(.bold)
                                .padding()
                                .frame(width: 200)
                                .background(Color("AccentColor2"))
                                .foregroundColor(.black)
                                .cornerRadius(30)
                        }
                        .padding()
                        .navigationDestination(isPresented: $navigateToAddMore) {
                            AllocationsView()
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true) // ✅ Hide the default back button
        }
        .onAppear(perform: fetchAllocations)
    }

    func fetchAllocations() {
        allocations = []
        totalAllocated = 0

        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        let group = DispatchGroup()

        // Fetch from energyBills
        group.enter()
        db.collection("users").document(uid).collection("energyBills").getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                for doc in documents {
                    let data = doc.data()
                    let item = AllocationItem(
                        id: doc.documentID,
                        nickname: data["nickname"] as? String ?? "",
                        allocatedPanels: data["allocatedPanels"] as? Int ?? 0,
                        kilowatt: data["kilowatt"] as? Double ?? 0.0
                    )
                    allocations.append(item)
                    totalAllocated += item.allocatedPanels
                }
            }
            group.leave()
        }

        // Fetch from paypalAllocations
        group.enter()
        db.collection("users").document(uid).collection("paypalAllocations").getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                for doc in documents {
                    let data = doc.data()
                    let item = AllocationItem(
                        id: doc.documentID,
                        nickname: data["nickname"] as? String ?? "",
                        allocatedPanels: data["allocatedPanels"] as? Int ?? 0,
                        kilowatt: data["kilowatt"] as? Double ?? 0.0
                    )
                    allocations.append(item)
                    totalAllocated += item.allocatedPanels
                }
            }
            group.leave()
        }

        // Fetch from bankAccounts
        group.enter()
        db.collection("users").document(uid).collection("bankAccounts").getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                for doc in documents {
                    let data = doc.data()
                    let item = AllocationItem(
                        id: doc.documentID,
                        nickname: data["nickname"] as? String ?? "",
                        allocatedPanels: data["allocatedPanels"] as? Int ?? 0,
                        kilowatt: data["kilowatt"] as? Double ?? 0.0
                    )
                    allocations.append(item)
                    totalAllocated += item.allocatedPanels
                }
            }
            group.leave()
        }

        group.notify(queue: .main) {
            totalLeft = max(0, totalPanels - totalAllocated)
        }
    }
}

#Preview {
    AllocationsHomeView()
}
