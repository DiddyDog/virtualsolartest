import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct EnergyBillView: View {
    @Environment(\.dismiss) var dismiss

    @State private var selectedCompany: String = "Choose"
    @State private var showCompanyPicker = false
    @State private var billerCode: String = ""
    @State private var reference: String = ""
    @State private var nickname: String = ""

    // Validation flags
    @State private var showCompanyError = false
    @State private var showBillerCodeError = false
    @State private var showReferenceError = false
    @State private var showNicknameError = false

    let energyCompanies = [
        "Choose", "AGL", "Origin Energy", "EnergyAustralia", "Red Energy",
        "Powershop", "Simply Energy", "Lumo Energy", "Alinta Energy",
        "Momentum Energy", "Tango Energy", "Diamond Energy", "Amber Electric",
        "Blue NRG", "Nectr", "Sumo", "OVO Energy", "ReAmped Energy"
    ]

    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()

            VStack(spacing: 20) {
                // Logo centered
                HStack {
                    Spacer()
                    Image("SolarCloudLogo")
                        .resizable()
                        .frame(width: 28.86, height: 50)
                    Spacer()
                }

                // Title and Back
                HStack(spacing: 10) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("AccentColor2"))
                    }

                    Text("Energy company")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal)

                Text("Enter the Bpay details from your Energy companies bill.")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Group {
                    // Company Dropdown
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Select an Energy Company")
                            .foregroundColor(.gray)

                        Button {
                            showCompanyPicker.toggle()
                        } label: {
                            HStack {
                                Text(selectedCompany)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color("AccentColor3"))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(showCompanyError ? Color.red : Color.clear, lineWidth: 2)
                            )
                        }

                        if showCompanyError {
                            Text("Please select a valid energy company.")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }

                    // Biller Code
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Biller Code:")
                            .foregroundColor(.gray)

                        TextField("Enter biller code", text: $billerCode)
                            .padding()
                            .background(Color("AccentColor3"))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(showBillerCodeError ? Color.red : Color.clear, lineWidth: 2)
                            )

                        if showBillerCodeError {
                            Text("Biller code is required.")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }

                    // Reference
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Ref:")
                            .foregroundColor(.gray)

                        TextField("Enter reference", text: $reference)
                            .padding()
                            .background(Color("AccentColor3"))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(showReferenceError ? Color.red : Color.clear, lineWidth: 2)
                            )

                        if showReferenceError {
                            Text("Reference is required.")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }

                    // Nickname
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nickname:")
                            .foregroundColor(.gray)

                        TextField("Enter nickname", text: $nickname)
                            .padding()
                            .background(Color("AccentColor3"))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(showNicknameError ? Color.red : Color.clear, lineWidth: 2)
                            )

                        if showNicknameError {
                            Text("Nickname is required.")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal)

                // Add Button
                Button(action: validateAndSave) {
                    Text("Add")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("AccentColor2"))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                // Logo
                Image("bpay_logo")
                    .resizable()
                    .frame(width: 100, height: 40)
                    .padding(.top, 10)

                Spacer()
            }
            .padding(.top)
        }
        .sheet(isPresented: $showCompanyPicker) {
            ZStack {
                Color("AccentColor3").ignoresSafeArea()

                VStack(spacing: 0) {
                    Text("Select Energy Company")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()

                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(energyCompanies, id: \.self) { company in
                                Button(action: {
                                    selectedCompany = company
                                    showCompanyPicker = false
                                }) {
                                    HStack {
                                        Text(company)
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color("AccentColor3").opacity(0.8))
                                    .cornerRadius(10)
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.bottom)
                    }
                }
            }
            .presentationDetents([.medium])
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Validation and Firestore
    func validateAndSave() {
        // Reset
        showCompanyError = false
        showBillerCodeError = false
        showReferenceError = false
        showNicknameError = false

        var hasError = false

        if selectedCompany == "Choose" {
            showCompanyError = true
            hasError = true
        }
        if billerCode.trimmingCharacters(in: .whitespaces).isEmpty {
            showBillerCodeError = true
            hasError = true
        }
        if reference.trimmingCharacters(in: .whitespaces).isEmpty {
            showReferenceError = true
            hasError = true
        }
        if nickname.trimmingCharacters(in: .whitespaces).isEmpty {
            showNicknameError = true
            hasError = true
        }

        if hasError { return }

        saveToFirestore()
    }

    func saveToFirestore() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let data: [String: Any] = [
            "company": selectedCompany,
            "billerCode": billerCode,
            "reference": reference,
            "nickname": nickname
        ]

        Firestore.firestore().collection("users").document(uid).collection("energyBills").addDocument(data: data) { error in
            if let error = error {
                print("❌ Firestore save failed: \(error.localizedDescription)")
            } else {
                print("✅ Energy bill info saved")
                dismiss()
            }
        }
    }
}

#Preview {
    EnergyBillView()
}
