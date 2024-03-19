//
//  CalendarHomeView.swift
//  MAHAN
//
//  Created by Anmol Singh on 2024-02-21.
//

import SwiftUI

struct CalendarHomeView: View {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    
    // MARK: Core Date Context
    @Environment(\.managedObjectContext) var context

    // MARK: Edit Button
    @Environment(\.editMode) var editButton
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            // MARK: Lazy Stack with Pinned Header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                
                Section {
                    
                    // MARK: Current Week View
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 10) {
                            
                            ForEach(taskModel.currentWeek, id: \.self) { day in
                                
                                VStack(spacing: 10) {
                                    
                                    Text(taskModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    
                                    // EEE will return day as MON, TUE, etc
                                    Text(taskModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(taskModel.isToday(date: day) ? 1 : 0)
        
                                }
                                // MARK: Forground Style
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(taskModel.isToday(date: day) ?.white : .black)
                                // MARK: Capsule Shape
                                .frame(width: 45, height: 90)
                                .background(
                                    
                                    ZStack{
                                        //MARK: Matched Geometry Effectively
                                        if taskModel.isToday(date: day) {
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                    
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation {
                                        taskModel.currentDate = day
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    
                    TasksView()
                    
                } header: {
                    HeaderView()
                    
                }
            }
        }
        .ignoresSafeArea(.container, edges: .top)
        // MARK: Add button
        .overlay(
            Button(action: {
                taskModel.newTask.toggle()
                
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black, in: Circle())
            })
            .padding()
            
            ,alignment: .bottomTrailing
        )
        .sheet(isPresented: $taskModel.newTask) {
            // Clearing Edit Data
            taskModel.editTask = nil
        } content: {
            NewTaskView()
                .environmentObject(taskModel)
        }
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
    
    // MARK: Tasks View
    func TasksView()->some View {
        
        LazyVStack (spacing: 20){
            
            // Converting onject as our task model
            DynamicFilteredView(dateToFilter: taskModel.currentDate) { (object: CalendarTask) in
                
                TaskCardView(task: object)
                
            }
            
        }
        .padding()
        .padding(.top)
        
        }
    
    
    // MARK: Task Card View
    func TaskCardView(task: CalendarTask)->some View {
        
        // MARK: Since CoreData values will give optimal data
        HStack(alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 30){
            
            // If edit mode enabled then showing delete button
            if editButton?.wrappedValue == .active {
                
                // Edit Button for Current and Future Tasks
                VStack(spacing: 10) {
                    
                    if task.taskDate?.compare(Date()) == .orderedDescending || Calendar.current.isDateInToday(task.taskDate ?? Date()){
                        
                        Button {
                            taskModel.editTask = task
                            taskModel.newTask.toggle()
                           } label : {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        
                    }
                    
                    Button {
                        // MARK: Deleting Tasks
                        context.delete(task)
                        
                        // Saving
                        try? context.save()
                         
                    } label : {
                        Image(systemName: "minus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                }
                
            }
            
            VStack(spacing: 10) {
                Circle()
                    .fill(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? (task.isCompleted ? .green : .black) : .clear)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    
                    )
                    .scaleEffect(!taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0.8 : 1)
                
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            
            VStack {
                
                HStack (alignment: .top, spacing: 10){
                    
                    VStack (alignment: .leading, spacing: 12) {
                        
                        Text(task.taskTitle ?? "")
                            .font(.title2.bold())
                        
                        Text(task.taskDescription ?? "")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        
                    }
                    .hLeading()
                    
                    Text(task.taskDate?.formatted(date: .omitted, time: .shortened) ?? "")
  
                }
                
                // MARK: Check Button
                if !task.isCompleted {
                    Button {
                        // MARK: Updating Tasks
                        task.isCompleted = true
                        
                        // Saving
                        try? context.save()
                        
                    } label: {
                        
                        Image(systemName: "checkmark")
                            .foregroundStyle(.black)
                            .padding(10)
                            .background(Color.white, in: Circle())
                        
                    }
                }
                
                Text(task.isCompleted ? "Marked as Completed" : "Mark Task as Completed")
                    .font(.system(size: task.isCompleted ? 14 : 16, weight: .light))
                    .foregroundColor(task.isCompleted ? .gray : .white)
                    .hLeading()
                
                
                
            }
            .foregroundColor(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? .white : .black)
            .padding(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 15 : 0)
            .padding(.bottom, taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0 : 10)
            .hLeading()
            .background(
                Color.black
                .cornerRadius(25)
                .opacity(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 1: 0)            )
        }
        .hLeading()
        
    }
    
    // MARK: Header
        func HeaderView()->some View{
            HStack (spacing: 10) {
                VStack (alignment: .leading, spacing: 10) {
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .foregroundColor(.gray)
                    
                    Text("Today")
                        .font(.largeTitle.bold())
                }
                .hLeading()
                
                // MARK: Edit Button
                EditButton()
            }
            .padding()
            .padding(.top, getSafeArea().top)
            .background(Color.white)
        }
    
}

struct CalendarHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHomeView()
    }
}

// MARK UI DESIGN Helper functions

extension View {
    func hLeading()->some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing()->some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter()->some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    // MARK: Safe Area
    func getSafeArea()->UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        
        return safeArea
    }
    
}


