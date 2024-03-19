//
//  NewAppointmentView.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-02-22.
//

import SwiftUI

struct NewTaskView: View {
    @Environment(\.dismiss) var dismiss
    
    // MARK: Task Values
    @State var taskTitle: String = ""
    @State var taskDescription: String = ""
    @State var taskDate: Date = Date()
    
    // MARK: Core Data Context
    @Environment(\.managedObjectContext) var context
    
    @EnvironmentObject var taskModel: TaskViewModel
    
    var body: some View {
        NavigationView {
            
            List {
                
                Section {
                    TextField("", text: $taskTitle)
                    
                } header: {
                    Text("Task Title")
                }
                
                Section {
                    TextField("", text: $taskDescription)
                    
                } header: {
                    Text("Task Description")
                }
                
                if taskModel.editTask == nil {
                    
                    Section {
                        DatePicker("", selection: $taskDate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                        
                    } header: {
                        Text("Task Date")
                    }
                    
                }
                
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Add New Task")
            .navigationBarTitleDisplayMode(.inline)
            // MARK: Disabling Dismiss on Swipe
            .interactiveDismissDisabled()
            // MARK: Action Buttons
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        
                        if let task = taskModel.editTask {
                            task.taskTitle = taskTitle
                            task.taskDescription = taskDescription    
                        } else {
                            let task = CalendarTask(context: context)
                            task.taskTitle = taskTitle
                            task.taskDescription = taskDescription
                            task.taskDate = taskDate
                        }
                        
                        // Saving
                        try? context.save()
                        
                        // Dismissing View
                        dismiss()
                        
                    }
                    .disabled(taskTitle == "" || taskDescription == "")
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            
            // Loading task data if from edit
            .onAppear() {
                if let task = taskModel.editTask {
                    taskTitle = task.taskTitle ?? ""
                    taskDescription = task.taskDescription ?? ""
                    
                }
            }
            
        }
    }
}


