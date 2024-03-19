//
//  Tab.swift
//  MedicalFeature
//
//  Created by Anmol Singh on 2024-02-23.
//

import SwiftUI

enum Tab: String {
    case records = "Records"
    case search = "Search"
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .records:
            Image(systemName: "calendar")
            Text(self.rawValue)
        
        case .search:
            Image(systemName: "magnifyingglass")
            Text(self.rawValue)
        }
    }
}
