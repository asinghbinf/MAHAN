//
//  ViewExtensions.swift
//  MedicalFeature
//
//  Created by Anmol Singh on 2024-02-24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)
    }
    
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)
    }
    
    var safeArea: UIEdgeInsets {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        
        return .zero
    }
    
    func format(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
}
