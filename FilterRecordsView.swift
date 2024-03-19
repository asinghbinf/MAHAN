//
//  FilterRecordsView.swift
//  MedicalFeature
//
//  Created by Anmol Singh on 2024-02-24.
//

import SwiftUI
import SwiftData

// Custom View
struct FilterRecordsView<Content: View>: View {
    var content: ([Details]) -> Content
    
    @Query(animation: .snappy) private var details: [Details]
    init(category: Category?, searchText: String, @ViewBuilder content: @escaping ([Details]) -> Content) {
        // Custom Predicate
        let rawValue = category?.rawValue ?? ""
        let predicate = #Predicate<Details> { detail in
            return (detail.title.localizedStandardContains(searchText) || detail.remarks.localizedStandardContains(searchText)) &&
            (rawValue.isEmpty ? true : detail.category == rawValue)
        }
        
        _details = Query(filter: predicate, sort: [
            SortDescriptor(\Details.dateAdded, order: .reverse)
        ], animation: .snappy)
        
        self.content = content
    }


    init(startDate: Date, endDate: Date, @ViewBuilder content: @escaping ([Details]) -> Content) {
        
        let predicate = #Predicate<Details> { detail in
            return (detail.dateAdded >= startDate && detail.dateAdded <= endDate)
        }
        
        _details = Query(filter: predicate, sort: [
            SortDescriptor(\Details.dateAdded, order: .reverse)
        ], animation: .snappy)
        
        self.content = content
    }

    var body: some View {
        content(details)
    }
}

