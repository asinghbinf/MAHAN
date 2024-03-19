//
//  RecordsView.swift
//  MedicalFeature
//
//  Created by Anmol Singh on 2024-02-24.
//

import SwiftUI
import SwiftData

struct RecordsView: View {
    
    // View Properties
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var showFilterView: Bool = false
    @State private var SelectedCategory: Category = .appointment
    
    // For Animation
    @Namespace private var animation
    //@Query(sort: [SortDescriptor(\Details.dateAdded, order: .reverse)], animation: .snappy) private var details: [Details]

    var body: some View {
        GeometryReader {
            
            // For animation purpose
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            // Date Filter Button
                            Button(action: {
                                showFilterView = true
                            }, label: {
                                Text("\(format(date: startDate, format: "MMM dd yyyy")) to \(format(date: endDate, format: "MMM dd yyyy"))")
                                //.font(.system(size: 18))
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            })
                            .hSpacing(.leading)
                            
                            FilterRecordsView(startDate: startDate, endDate: endDate) {details in
                                
                                CustomSegmentedControl()
                                    .padding(.bottom, 10)
                                
                                ForEach(details.filter({ $0.category == SelectedCategory.rawValue })) { detail in
                                    NavigationLink(value: detail) {
                                        RecordCardView(details: detail)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        } header: {
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showFilterView ? 5 : 0)
                .disabled(showFilterView)
                .navigationDestination(for: Details.self) { detail in
                    NewRecordView(editDetails: detail)
                }     
            }
            .overlay {
                if showFilterView {
                    DateFilterView(start: startDate, end: endDate, onSubmit: { start, end in
                        startDate = start
                        endDate = end
                        showFilterView = false
                    }, onClose: {
                        showFilterView = false
                    })
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.snappy, value: showFilterView)
        }
    }
    
    // Header View
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack(spacing: 10) {
            
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Medical Records")
                    .font(.title.bold())
            })
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
            Spacer()
            
            NavigationLink {
                NewRecordView()
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle)
            }
            
        }
        //.padding(.bottom, 5)
        .background {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Divider()
                
            }
            .visualEffect { content, geometryProxy in
                content
                    .opacity(headerBGOpactiy(geometryProxy))
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }
    
    // Segmented Control
    
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.rawValue) {category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical, 10)
                    .background {
                        if category == SelectedCategory {
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            SelectedCategory = category
                        }
                    }
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top, 5)
    }
     
    
    func headerBGOpactiy(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY / 15)
    }
    
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height

        let progress = minY / screenHeight
        let scale = (min(max(progress, 0), 1)) * 0.6
        
        return 1 + scale
    }
}

#Preview {
    ContentView()
}


