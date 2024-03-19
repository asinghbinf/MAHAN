//
//  Details.swift
//  MedicalFeature
//
//  Created by Anmol Singh on 2024-02-24.
//

import SwiftUI
import SwiftData

@Model
class Details {

    // Properties
    var title: String
    var remarks: String
    var dateAdded: Date
    var category: String
    var tintColour: String
    
    init(title: String, remarks: String, dateAdded: Date, category: Category, tintColour: TintColour) {
        self.title = title
        self.remarks = remarks
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColour = tintColour.colour
    }
    
    // Extracting colour value from tintColour string
    @Transient
    var colour: Color {
        return tints.first(where: { $0.colour == tintColour})?.value ?? appTint
    }
    
    @Transient
    var tint: TintColour? {
        return tints.first(where: { $0.colour == tintColour })
    }
    
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: { category == $0.rawValue })
    }
    
}

