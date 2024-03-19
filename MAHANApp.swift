//
//  MAHANApp.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-01-13.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct MAHANApp: App {
    
    @StateObject var viewModel = AuthViewModel()

    let persistenceContainer = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
        .modelContainer(for: [Details.self])
        //.modelContainer(for: Medications.self)
        //.modelContainer(sharedModelContainer)
    }
}


