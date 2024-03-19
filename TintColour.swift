//
//  TintColour.swift
//  MedicalFeature
//
//  Created by Anmol Singh on 2024-02-24.
//

import SwiftUI

// Custom Tint Colours for Appointment Type
struct TintColour: Identifiable {
    let id: UUID = .init()
    var colour: String
    var value: Color
}

var tints: [TintColour] = [
    .init(colour: "Gray", value: .gray),
    .init(colour: "Pink", value: .pink),
    .init(colour: "Purple", value: .purple),
    .init(colour: "Brown", value: .brown),
    .init(colour: "Orange", value: .orange),
    .init(colour: "Teal", value: .teal),
]
