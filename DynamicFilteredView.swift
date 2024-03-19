//
//  DynamicFilteredView.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-02-22.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject {
    
    // MARK: Core Data Request
    @FetchRequest var request: FetchedResults<T>
    let content: (T)->Content
    
    // MARK: Building Custom ForEach will give Coredata object to build view
    init(dateToFilter: Date, @ViewBuilder content: @escaping (T)->Content) {
        
        // MARK: Predicate to Filter current date tasks
        let calendar = Calendar.current
        
        let today = calendar.startOfDay(for: dateToFilter)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        // Filter key
        let filterKey = "taskDate"
        
        // Fetch task between today and tomorrow which is within 24 hours
        let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) =< %@", argumentArray: [today, tomorrow])
        
        // Initializing Request with NSPredicate
        // Adding Sort
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \CalendarTask.taskDate, ascending: false)], predicate: predicate)
        self.content = content
        
    }
    
    var body: some View {
        Group {
            
            if request.isEmpty {
                Text("No upcoming appointments")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y: 100)
                
            } else {
                
                ForEach(request, id: \.objectID) {object in
                    self.content(object)
                }
                
            }
            
        }
    }
}


