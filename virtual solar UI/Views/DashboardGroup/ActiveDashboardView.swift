import SwiftUI
import Charts

// Main Active Dashboard View
struct ActiveDashboardView: View {
    enum FocusedField{
        case dec
    }
    @StateObject private var viewModel = ActiveDashboardViewModel()
    @State private var energyBillAmount = ""
    @FocusState private var focusedField: FocusedField?
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack(spacing: 20) {
                    
                    // MARK: - Allocation Navigation Button
                    allocationNavigationButton
                    
                    // MARK: - Savings Section
                    savingsSection
                    
                    // MARK: - Active Panels Section
                    virtualPanelsSection
                }
                .padding(.bottom, 50)
            }
            // tool bar for decimal keypad
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        focusedField = nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
    }
    
    // MARK: - Allocation Navigation Button View
    private var allocationNavigationButton: some View {
        HStack {
            NavigationLink(destination: AllocationView()) {
                HStack {
                    Text("Select allocations")
                        .font(.custom("PoppinsSemiBold", size: 16))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color("AccentColor5"))
                .cornerRadius(8)
                Spacer()
            }
        }
        .padding(.horizontal)
        
    }
    
    // MARK: - Savings Section Box
    private var savingsSection: some View {
        VStack(alignment: .leading, spacing: 25) {
            // Info Cards
            infoCards
            
            // Savings Data
            savingsData
        }
        .frame(maxWidth: 330)
        .padding(.vertical, 12) // was .padding()
        .padding(.horizontal, 14)
        .background(Color("AccentColor4"))
        .cornerRadius(26)
        
    }
    
    // MARK: - Info Cards
    private var infoCards: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                InfoCard(title: "Active", value: "\(viewModel.activePower) kW")
                InfoCard(title: "Last quarter", value: "$\(viewModel.lastQuarterSavings)")
            }
            
            HStack(spacing: 10) {
                InfoCard(title: "Total savings", value: "$\(viewModel.totalSavings)")
                InfoCard(title: "This quarter to date", value: "$\(viewModel.currentQuarterSavings)")
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal,36)
    }
    
    // MARK: - Savings Data
    private var savingsData: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                Spacer()
                Text("Savings")
                    .font(.custom("Poppins-SemiBold", size: 34))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                Spacer()
            }
            .padding(.bottom, 20)
            
            HStack {
                
                SavingsProgressCircle(percentage: calculatedSavingsPercentage)
                    .padding(.top, 20)
                    .padding(.leading, 20)
                
                Spacer()
                
                HStack {
                    Spacer().frame(width: 50)
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Last quater")
                            .font(.custom("Poppins-SemiBold", size: 15))
                            .foregroundColor(.white)
                        Spacer()
                        Text("$\(viewModel.lastQuarterAmount)")
                            .font(.custom("Poppins-SemiBold", size: 22))
                            .foregroundColor(Color("AccentColor2"))
                        
                        Spacer().padding(.top, 4)
                        Text("Old energy bill")
                            .font(.custom("Poppins-SemiBold", size: 15))
                            .foregroundColor(.white)
                        Spacer()
                        HStack {
                            HStack {
                                //fix this and fix preview
                                Text("$")
                                    .font(.custom("Poppins-SemiBold", size: 22))
                                    .foregroundColor(Color("AccentColor2"))
                                TextField("Amount", text: $energyBillAmount)
                                    .focused($focusedField, equals: .dec)
                                    .keyboardType(.decimalPad)
                                    .font(.custom("Poppins-SemiBold", size: 22))
                                    .foregroundColor(Color("AccentColor2"))
                                    .frame(width: 92)
                                Spacer()
                            }
                            // Removed .toolbar from here
                        }
                    }
                }
            }
            //Content under savings graph
            HStack {
                Spacer()
                Rectangle()
                    .fill(Color("AccentColor2"))
                    .frame(width: 300, height: 1.5)
                Spacer()
            }
            .padding(.top, 33)
            .padding(.bottom, 6)
            
            Text("To eliminate your Electricity Bill visit our ")
                .font(.custom("Poppins", size: 13))
                .foregroundColor(.white)
            +
            Text("website")
                .font(.custom("Poppins", size: 13))
                .foregroundColor(.white)
                .underline()
            +
            Text(" to update your SolarCloud portfolio.")
                .font(.custom("Poppins", size: 13))
        }
        .foregroundColor(.white)
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
    
    //MARK: - savings circle percentage calculation
    private var calculatedSavingsPercentage: Double {
        guard let oldBill = Double(energyBillAmount),
              oldBill > 0,
              let lastQuarter = Double(viewModel.lastQuarterSavings) else {
            return 0
        }
        return min(lastQuarter / oldBill, 1.0) // Clamp to 1.0 (100%)
    }
    

    //MARK: - Savings Progress Circle
    struct SavingsProgressCircle: View {
        var percentage: Double // 0...1

        var body: some View {
            ZStack {
                Circle()
                    .stroke(Color("BackgroundColor"), lineWidth: 12)
                    .frame(width: 100, height: 100)
                Circle()
                    .trim(from: 0, to: percentage)
                    .stroke(Color("AccentColor1"), style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 100, height: 100)
                    .animation(.easeOut(duration: 1.0), value: percentage)
                VStack {
                    Text("\(Int(percentage * 100))%")
                        .font(.custom("Poppins-SemiBold", size: 22))
                        .foregroundColor(.white)
                    Text("saved")
                        .font(.custom("Poppins-SemiBold", size: 16))
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    // MARK: - Virtual Panels Section View
    private var virtualPanelsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .center) {
                Spacer()
                Text("My virtual panels")
                    .font(.custom("Poppins-SemiBold", size: 34))
                    .foregroundColor(.white)
                Spacer()
            }
            
            HStack {
                Button(action: {
                    // Previous month action - use viewModel.currentDate as reference
                    if let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: viewModel.currentDate) {
                        viewModel.loadDataForMonth(previousMonth)
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(Color("BackgroundColor"))
                        .clipShape(Circle())
                }
                .padding(.leading, 22)
                Spacer()
                
                Text(viewModel.currentMonthYear)
                    .foregroundColor(.white)
                    .font(.custom("Poppins-SemiBold", size: 24))
                
                Spacer()
                
                Button(action: {
                    let calendar = Calendar.current
                    if let nextMonth = calendar.date(byAdding: .month, value: 1, to: viewModel.currentDate) {
                        // Only allow advancing if nextMonth is not in the future
                        if nextMonth <= Date() {
                            viewModel.loadDataForMonth(nextMonth)
                        }
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(viewModel.canNavigateToNextMonth() ? .white : .gray)
                        .frame(width: 36, height: 36)
                        .background(Color("BackgroundColor"))
                        .clipShape(Circle())
                }
                .padding(.trailing, 22)
                .disabled(!viewModel.canNavigateToNextMonth())
            }
            
            HStack {
                VStack {
                    Text("Active")
                        .font(.custom("Poppins", size: 16))
                        .foregroundColor(.white)
                    
                    Text(viewModel.totalEnergy)
                        .font(.headline)
                        .foregroundColor(Color("AccentColor1"))
                    
                    Image("LineGraphIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 24)
                }
                Spacer()
                
                Image("CO2Icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 24)
                
                Text(viewModel.totalCO2Saved + " Kg's")
                    .font(.custom("Poppins", size: 16))
                    .foregroundColor(Color("AccentColor1"))
                +
                Text(" saved")
                    .font(.custom("Poppins", size: 16))
                    .foregroundColor(.white)
            }
            
            energyBarChart
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("AccentColor4"))
        .cornerRadius(26)
        .padding(.horizontal)
    }

    // MARK: - Energy Bar Chart
    private var energyBarChart: some View {
        
        HStack(alignment: .top, spacing: 0) {
            // Fixed Y-axis
            Chart {
                // Empty content just for the axis
                ForEach([0], id: \.self) { _ in
                    BarMark(
                        x: .value("", ""),
                        y: .value("", 0)
                    )
                    .opacity(0)
                }
            }
            .chartYScale(domain: 0...450)
            .chartYAxis {
                AxisMarks(position: .leading, values: .stride(by: 100)) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel {
                        if let kW = value.as(Double.self) {
                            Text("\(Int(kW))")
                                .font(.custom("Poppins", size: 14))
                                .foregroundColor(.white)
                                .offset(y: -10)
                        }
                    }
                }
            }
            .chartXAxis(.hidden)
            .frame(width: 40, height: 260)
            .padding(.trailing, 4)
            

            // Scrollable chart area
            ScrollView(.horizontal, showsIndicators: false) {
                Chart {
                    ForEach(viewModel.dailyEnergyData) { dayData in
                        BarMark(
                            x: .value("Day", dayData.dayString),
                            y: .value("kW", dayData.kW)
                        )
                        .foregroundStyle(Color("AccentColor1"))
                        .annotation(position: .top) {
                            Text("\(Int(dayData.kW))")
                                .font(.custom("Poppins", size: 14))
                                .foregroundColor(.white)
                        }
                    }
                }
                .chartYScale(domain: 0...450)
                .chartYAxis(.hidden)
                .chartXAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel {
                            if let day = value.as(String.self) {
                                Text(day)
                                    .font(.custom("Poppins", size: 14))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .frame(width: CGFloat(viewModel.dailyEnergyData.count) * 40, height: 260)
            }
        }
        
    }}

//MARK: - InfoCard Component
struct InfoCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(.custom("Poppins-SemiBold", size: 16))
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .font(.custom("Poppins-SemiBold", size: 20))
                .foregroundColor(Color("AccentColor2"))
                .padding(.bottom, 10)
        }
        .padding()
        .frame(width: 150, height: 140)
        .background(Color("BackgroundColor"))
        .cornerRadius(12)
    }
}

#Preview {
    DashboardView()
}
