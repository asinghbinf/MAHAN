//
//  SideMenuOptionModel.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-02-21.
//

import Foundation

enum SideMenuOptionModel: Int, CaseIterable {
    
    case home
    case weekly_calendar
    case records
    case profile
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .weekly_calendar:
            return "Appointments"
        case .records:
            return "Medical Records"
        case .profile:
            return "Account"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .home:
            return "house"
        case .weekly_calendar:
            return "calendar"
        case .records:
            return "book.pages"
        case .profile:
            return "person.crop.circle"
        }
    }
}

extension SideMenuOptionModel: Identifiable {
    var id: Int { return self.rawValue }
}
