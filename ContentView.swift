//
//  ContentView.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-01-13.
//

import SwiftUI
//import SwiftData


struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showMenu = false
    @State private var selectedTab = 0
   
    var body: some View {
        
        Group {
            if viewModel.userSession != nil {
                //ProfileView()
                NavigationStack {
                    ZStack {
                        
                        TabView(selection: $selectedTab) {
                            MAHANHomeView()
                                .tag(0)
                                              
                            CalendarHomeView()
                                .tag(1)
                            
                            MedicalRecordView()
                                .tag(2)
                            
                            ProfileView()
                                .tag(3)
     
                        }
                        
                        SideMenuView(isShowing: $showMenu, selectedTab: $selectedTab)
                    }
                    .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
                    //.navigationTitle("Home")
                    //.navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button (action: {
                                showMenu.toggle()
                            }, label: {
                                Image(systemName: "line.3.horizontal")
                            })
                        }
                        
                    }
                }
            } else {
                SignInView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}

