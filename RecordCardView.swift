//
//  RecordCardView.swift
//  MedicalFeature
//
//  Created by Anmol Singh on 2024-02-24.
//

import SwiftUI

struct RecordCardView: View {
    @Environment(\.modelContext) private var context
    var details: Details
    var showCategory: Bool = false
    
    var body: some View {
        SwipeActionView(cornerRadius: 10, direction: .trailing) {
            HStack(spacing: 12) {
                
                Text("\(String(details.category.prefix(1)))")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(details.colour.gradient, in: .circle)
                
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(details.title)
                        .foregroundStyle(Color.primary)
                    
                    Text(details.remarks)
                        .foregroundStyle(Color.primary.secondary)
                    
                    Text(format(date: details.dateAdded, format: "MMM dd yyyy"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    if showCategory {
                        Text(details.category)
                            .font(.caption2)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .foregroundStyle(.white)
                            .background(details.category == Category.appointment.rawValue ? Color.blue.gradient : Color.green.gradient, in: .capsule)
                    }
                     
                })
                .lineLimit(1)
                .hSpacing(.leading)
                
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(.background, in: .rect(cornerRadius: 10))
            
        } actions: {
            ActionModel(tint: .red, icon: "trash") {
                context.delete(details)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
