// ActiveDashboardViewModel.swift
import SwiftUI

// ViewModel for ActiveDashboardView
class ActiveDashboardViewModel: ObservableObject {
    // These properties will eventually be populated from Firebase
    @Published var activePower: String = "10.8" // Placeholder
    @Published var lastQuarterSavings: String = "157.50" // Placeholder
    @Published var totalSavings: String = "2,679.45" // Placeholder
    @Published var currentQuarterSavings: String = "52.50" // Placeholder
    @Published var savingsPercentage: String = "35%" // Placeholder
    @Published var lastQuarterAmount: String = "157.50" // Placeholder
    @Published var totalEnergy: String = "18155 kW" // Placeholder
    @Published var totalCO2Saved: String = "7242"
    @Published var currentDate: Date = Date()
    @Published var dailyEnergyData: [DailyEnergy] = []
    
    
    var currentMonthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    struct DailyEnergy: Identifiable {
        let id = UUID()
        let date: Date
        let kW: Double
        
        var dayString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "d"
            return formatter.string(from: date)
        }
        
        var monthDayString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d"
            return formatter.string(from: date)
        }
    }
    
    init() {
        generateEnergyData(for: currentDate)
    }
    
    private func generateEnergyData(for date: Date) {
        let calendar = Calendar.current
        
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let daysInMonth = calendar.range(of: .day, in: .month, for: date) else {
            return
        }
        
        var data: [DailyEnergy] = []
        let now = Date()
        
        for day in daysInMonth {
            if let dayDate = calendar.date(bySetting: .day, value: day, of: monthInterval.start) {
                // For current month, only include days that have passed
                if calendar.isDate(dayDate, inSameDayAs: now) || dayDate < now {
                    let kW = Double.random(in: 100...400)
                    data.append(DailyEnergy(date: dayDate, kW: kW))
                }
            }
        }
        
        dailyEnergyData = data
        
        // Update total energy
        let total = data.reduce(0) { $0 + $1.kW }
        totalEnergy = "\(Int(total)) kW"
    }
    
    func loadDataForMonth(_ date: Date) {
        currentDate = date
        generateEnergyData(for: date)
    }
    
    // ActiveDashboardViewModel.swift
    func canNavigateToNextMonth() -> Bool {
        let calendar = Calendar.current
        guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: currentDate) else {
            return false
        }
        // Set both dates to the first of their month for accurate comparison
        let nextMonthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: nextMonth))!
        let nowMonthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        return nextMonthStart <= nowMonthStart
    }
    
    // This function will be implemented later to fetch data from Firebase
    func fetchDashboardData() {
        // TODO: Implement Firebase data fetching
        // This will update all the @Published properties when implemented
    }
}
