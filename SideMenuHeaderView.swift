//
//  SideMenuHeaderView.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-02-21.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        HStack {
            Image(systemName: "person.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.white)
                .frame(width:48, height: 48)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical)
            
            if let user = viewModel.currentUser {
                VStack (alignment: .leading, spacing: 4) {
                    Text(user.fullName)
                        .font(.subheadline)
                    
                    Text(user.email)
                        .font(.footnote)
                        .tint(.gray)
                }
            }
            
            
        }
        
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView()
            .environmentObject(AuthViewModel())
    }
}
