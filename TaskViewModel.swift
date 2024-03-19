//
//  TaskViewModel.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-02-21.
//

import SwiftUI

class TaskViewModel: ObservableObject {

    
    // MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    
    // MARK: Current Day
    @Published var currentDate: Date = Date()
    
    // MARK: Filtering Today Tasks
    @Published var filteredTasks: [CalendarTask]?
    
    // MARK: New Task
    @Published var newTask: Bool = false
    
    // MARK: Edit Date
    @Published var editTask: CalendarTask?
    
    // MARK: Initializing
    init() {
        fetchCurrentWeek()
    }
    
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach { day in
            
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
            
        }
        
    }
    
    // MARK: Extracting Date
    
    func extractDate(date: Date, format: String)->String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    // MARK: Checking if current date is today
    func isToday(date: Date)-> Bool {
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDate, inSameDayAs: date)
    }
    
    // MARK: Checking if currentHour is task hour
    func isCurrentHour(date: Date)->Bool {
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        let isToday = calendar.isDateInToday(date)
        
        return (hour == currentHour && isToday)
    }
    
}
