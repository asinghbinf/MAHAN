//
//  MAHANHomeView.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-02-25.
//

import SwiftUI

struct MAHANHomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Image
            Image(.MAHAN_LOGO)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 200)
                .padding(.vertical, 20)
            
            Text("MAHAN")
                .font(.system(size:40))
                .foregroundColor(Color(Color.mint.opacity(0.8)))
            Text("Mind And Health Aid Network")
                .font(.system(size:20))
                .foregroundColor(Color(Color.mint.opacity(0.8)))
            
            Text("Designed for caregivers by a caregiver.")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            VStack(alignment: .center, spacing: 20.0) {
                
                VStack {
                    Text("Appointments")
                        .font(.title3)
                        .multilineTextAlignment(.center)

                    
                    Text("Add, edit, and see upcoming appointments.")
                        .multilineTextAlignment(.center)
                }
                
                
                VStack {
                    Text("Medical Records")
                        .font(.title3)
                    Text("Keep track of all records. Fitler, delete, and add your record history.")
                        .multilineTextAlignment(.center)
                }
                
                VStack {
                    Text("Account")
                        .font(.title3)
                    Text("Take a look at your user profile.")
                        .multilineTextAlignment(.center)
                }

                
            }
            .foregroundColor(Color(Color.black.opacity(0.8)))
            .frame(width: 300.0)
        }
  
    }
}

#Preview {
    MAHANHomeView()
}
