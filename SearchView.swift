//
//  SearchView.swift
//  MedicalFeature
//
//  Created by Anmol Singh on 2024-02-24.
//

import SwiftUI
import Combine

struct SearchView: View {
    // View Properties
    @State private var searchText: String = ""
    @State private var filterText: String = ""
    @State private var selectedCategory: Category? = nil
    let searchPublisher = PassthroughSubject<String, Never>()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    
                    FilterRecordsView(category: selectedCategory, searchText: filterText) { details in
                        
                        ForEach(details) { detail in
                            NavigationLink {
                                RecordCardView(details: detail)
                            } label: {
                                RecordCardView(details: detail, showCategory: true)
                                
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(15)
            }
            
            .overlay(content: {
                ContentUnavailableView("Search Records", systemImage: "magnifyingglass")
                    .opacity(filterText.isEmpty ? 1: 0)
            })
            
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    filterText = ""
                }
                searchPublisher.send(newValue)
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                filterText = text
            })
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ToolBarContent()
                }
            }
        }
    }
    
    @ViewBuilder
    func ToolBarContent() -> some View {
        Menu {
            Button {
               selectedCategory = nil
            } label: {
                HStack {
                    Text("Both")
                    
                    if selectedCategory == nil {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            ForEach(Category.allCases, id: \.rawValue) { category in
                Button {
                   selectedCategory = category
                } label: {
                    HStack {
                        Text(category.rawValue)
                        
                        if selectedCategory == category {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "slider.vertical.3")
        }
    }
}

#Preview {
    SearchView()
}
