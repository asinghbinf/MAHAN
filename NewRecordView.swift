//
//  NewRecordView.swift
//  MedicalFeature
//
//  Created by Anmol Singh on 2024-02-24.
//

import SwiftUI

struct NewRecordView: View {
    // Environment Properties
    @Environment(\.modelContext) private var content
    @Environment(\.dismiss) private var dismiss
    var editDetails: Details?
    // View Properties
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var dateAdded: Date = .now
    @State private var category: Category = .appointment
    
    // Random Tint
    @State var tint: TintColour = tints.randomElement()!
    
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                Text("Preview")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .hSpacing(.leading)
                
                // Preview Record Card View
                RecordCardView(details: .init(title: title.isEmpty ? "Title": title,
                                              remarks: remarks.isEmpty ? "Remarks": remarks,
                                              dateAdded: dateAdded,
                                              category: category,
                                              tintColour: tint
                ))
                
                CustomSection("Title", "Event", value: $title)
                
                CustomSection("Remarks", "Additional Remarks", value: $remarks)
                
                // Category Check Box
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    HStack(spacing: 15) {
                        CategoryCheckbox()
                    }
                })
                
                // Date Picker:
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                })
            
            }
            .padding(15)
        }
        .navigationTitle("\(editDetails == nil ? "Add" : "Edit") Record")
        .background(.gray.opacity(0.15))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", action: save)
            }
        })
        .onAppear(perform: {
            if let editDetails {
                // Load all existing data from the details
                title = editDetails.title
                remarks = editDetails.remarks
                dateAdded = editDetails.dateAdded
                if let category = editDetails.rawCategory {
                    self.category = category
                }
                if let tint = editDetails.tint {
                    self.tint = tint
                }
            }
        })
    }
    
    // Saving Data
    func save() {
        if editDetails != nil {
            editDetails?.title = title
            editDetails?.remarks = remarks
            editDetails?.dateAdded = dateAdded
            editDetails?.category = category.rawValue
        } else {
            // Saving item to SwiftData
            let details = Details(title: title, remarks: remarks, dateAdded: dateAdded, category: category, tintColour: tint)
            
            content.insert(details)
        }
        
        // Dismiss View
        dismiss()
    }
    
    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
        
        VStack(alignment: .leading, spacing: 10, content: {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        })
    }
    
    // Custom Checkbox
    @ViewBuilder
    func CategoryCheckbox() -> some View {
        HStack(spacing: 10) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(appTint)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(appTint)
                        }
                    }
                    
                    Text(category.rawValue)
                        .font(.system(size: 14))
                }
                .contentShape(.rect)
                .onTapGesture{
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
        .frame(maxWidth: 250)
    }
}


#Preview {
    NavigationStack {
        NewRecordView()
    }
}

