import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct AllocationItem: Identifiable {
    let id: String
    let nickname: String
    let allocatedPanels: Int
    let kilowatt: Double
    let source: String // energyBills, paypalAllocations, bankAccounts
}

struct AllocationsHomeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var allocations: [AllocationItem] = []
    @State private var totalAllocated = 0
    @State private var totalLeft = 6
    @State private var navigateToAddMore = false

    @State private var selectedToDelete: AllocationItem?
    @State private var showDeleteAlert = false

    var totalPanels = 6

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 20) {
                        HStack {
                            Spacer()
                            Image("SolarCloudLogo")
                                .resizable()
                                .frame(width: 28.86, height: 50)
                            Spacer()
                        }
                        .padding(.top)

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

                        HStack {
                            Spacer()
                            panelInfo(title: "allocated", count: totalAllocated)
                            Spacer()
                            panelInfo(title: "left", count: totalLeft)
                            Spacer()
                        }
                    }
                    .listRowBackground(Color("BackgroundColor"))
                }

                ForEach(allocations) { allocation in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Spacer()
                            VStack(spacing: 4) {
                                Text(allocation.nickname)
                                    .font(.headline)
                                    .foregroundColor(Color("AccentColor2"))
                                    .multilineTextAlignment(.center)
                                Text("\(allocation.allocatedPanels) panels allocated")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                        }

                        HStack {
                            Spacer()
                            VStack(spacing: 4) {
                                Text("Last quarter")
                                    .font(.caption)
                                    .foregroundColor(.white)

                                HStack(spacing: 20) {
                                    payoutBox(label: "last payout", amount: "$200")
                                    payoutBox(label: "Savings", amount: "$40")
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color("AccentColor5"))
                        .cornerRadius(20)
                    }
                    .padding(.vertical, 5)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            selectedToDelete = allocation
                            showDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .listRowBackground(Color("BackgroundColor"))
                }

                Section {
                    Button(action: {
                        if totalLeft > 0 {
                            navigateToAddMore = true
                        }
                    }) {
                        Text(totalLeft > 0 ? "Add" : "Buy more")
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("AccentColor2"))
                            .foregroundColor(.black)
                            .cornerRadius(30)
                    }
                    .padding()
                    .listRowBackground(Color("BackgroundColor"))
                }
            }
            .listStyle(.plain)
            .background(Color("BackgroundColor"))
            .scrollContentBackground(.hidden)
            .navigationDestination(isPresented: $navigateToAddMore) {
                AllocationsView()
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear(perform: fetchAllocations)
        .alert("Delete Allocation?", isPresented: $showDeleteAlert, presenting: selectedToDelete) { item in
            Button("Delete", role: .destructive) {
                deleteAllocation(item)
            }
            Button("Cancel", role: .cancel) {}
        } message: { _ in
            Text("Are you sure you want to delete this allocation?")
        }
    }

    @ViewBuilder
    func panelInfo(title: String, count: Int) -> some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            VStack {
                Text("\(count) panels")
                    .font(.subheadline)
                    .foregroundColor(Color("AccentColor2"))
                Text("\(String(format: "%.1f", Double(count) * 0.85))kW")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color("AccentColor3"))
            .cornerRadius(16)
        }
    }

    @ViewBuilder
    func payoutBox(label: String, amount: String) -> some View {
        VStack {
            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
            Text(amount)
                .foregroundColor(Color("AccentColor2"))
        }
    }

    func fetchAllocations() {
        allocations = []
        totalAllocated = 0

        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let group = DispatchGroup()

        // energyBills
        group.enter()
        db.collection("users").document(uid).collection("energyBills").getDocuments { snapshot, _ in
            if let documents = snapshot?.documents {
                for doc in documents {
                    let data = doc.data()
                    let item = AllocationItem(
                        id: doc.documentID,
                        nickname: data["nickname"] as? String ?? "",
                        allocatedPanels: data["allocatedPanels"] as? Int ?? 0,
                        kilowatt: data["kilowatt"] as? Double ?? 0.0,
                        source: "energyBills"
                    )
                    allocations.append(item)
                    totalAllocated += item.allocatedPanels
                }
            }
            group.leave()
        }

        // paypalAllocations
        group.enter()
        db.collection("users").document(uid).collection("paypalAllocations").getDocuments { snapshot, _ in
            if let documents = snapshot?.documents {
                for doc in documents {
                    let data = doc.data()
                    let item = AllocationItem(
                        id: doc.documentID,
                        nickname: data["nickname"] as? String ?? "",
                        allocatedPanels: data["allocatedPanels"] as? Int ?? 0,
                        kilowatt: data["kilowatt"] as? Double ?? 0.0,
                        source: "paypalAllocations"
                    )
                    allocations.append(item)
                    totalAllocated += item.allocatedPanels
                }
            }
            group.leave()
        }

        // bankAccounts
        group.enter()
        db.collection("users").document(uid).collection("bankAccounts").getDocuments { snapshot, _ in
            if let documents = snapshot?.documents {
                for doc in documents {
                    let data = doc.data()
                    let item = AllocationItem(
                        id: doc.documentID,
                        nickname: data["nickname"] as? String ?? "",
                        allocatedPanels: data["allocatedPanels"] as? Int ?? 0,
                        kilowatt: data["kilowatt"] as? Double ?? 0.0,
                        source: "bankAccounts"
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

    func deleteAllocation(_ allocation: AllocationItem) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("users")
            .document(uid)
            .collection(allocation.source)
            .document(allocation.id)
            .delete { error in
                if let error = error {
                    print("Delete failed: \(error.localizedDescription)")
                } else {
                    allocations.removeAll { $0.id == allocation.id && $0.source == allocation.source }
                    totalAllocated -= allocation.allocatedPanels
                    totalLeft = max(0, totalPanels - totalAllocated)
                }
            }
    }
}

#Preview {
    AllocationsHomeView()
}
