//
//  MedicalRecordView.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-02-25.
//

import SwiftUI
import SwiftData

struct MedicalRecordView: View {
    // Visibility Status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    
    // Active tab
    @State private var activeTab: Tab = .records

    var body: some View {
       
        TabView(selection: $activeTab) {
            RecordsView()
                .tag(Tab.records)
                .tabItem { Tab.records.tabContent }
            
            SearchView()
                .tag(Tab.search)
                .tabItem { Tab.search.tabContent }
        }
        .tint(appTint)
        .sheet(isPresented: $isFirstTime, content: {
            MedicalIntroView()
                .interactiveDismissDisabled()
        })
    }
}

#Preview {
    MedicalRecordView()
        //.modelContainer(for: Item.self, inMemory: true)
}
