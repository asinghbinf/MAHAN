//
//  MedicalIntroView.swift
//  MedicalFeature
//
//  Created by Anmol Singh on 2024-02-23.
//

import SwiftUI

struct MedicalIntroView: View {
    
    // Visibility Satus
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    
    var body: some View {
        
        VStack(spacing: 15) {
            Text("Medical History")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom)
            
            // Points View
            VStack(alignment: .leading, spacing: 25, content: {
                PointView(symbol: "list.clipboard", title: "Records", subtitle: "Keep track of your appointments and surgeries.")
                
                PointView(symbol: "magnifyingglass", title: "Advance Filters", subtitle: "Find any appointment or surgery using the advance search and filtering.")
        
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding(.horizontal, 25)
            
            Spacer(minLength: 10)
            
            Button(action: {
                isFirstTime = false
            }, label: {
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 14)
                    .background(appTint.gradient, in: .rect(cornerRadius: 12))
                    .contentShape(.rect)
            })
        }
        .padding(15)
    }
    
    // Points View
    @ViewBuilder
    func PointView(symbol: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 20) {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(appTint.gradient)
                .frame(width: 45)
            
            VStack(alignment: .leading, spacing: 6, content: {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .foregroundStyle(.gray)
            })
        }
    }
}

#Preview {
    MedicalIntroView()
}
