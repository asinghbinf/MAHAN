//
//  SideMenuRowView.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-02-21.
//

import SwiftUI

struct SideMenuRowView: View {
    let option: SideMenuOptionModel
    @Binding var selectedOption: SideMenuOptionModel?
    
    private var isSelected: Bool {
        return selectedOption == option
    }
    
    var body: some View {
        
        HStack {
            Image(systemName: option.systemImageName)
                .imageScale(.small)
            
            Text(option.title)
                .font(.subheadline)
            
            Spacer()
            
            
        }
        .padding(.leading)
        .foregroundStyle(isSelected ? .blue : .primary)
        .frame(width: 216, height: 44)
        .background(isSelected ? .blue.opacity(0.15) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct SideMenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuRowView(option: .home, selectedOption: .constant(.home))
        
    }
}
