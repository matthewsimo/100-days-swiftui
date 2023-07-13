//
//  ContentView.swift
//  Habit
//
//  Created by Matthew Simo on 7/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    @State private var showingAddActivity = false
    
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(activities.items) { activity in
                    NavigationLink {
                        ActivityView(activities: activities, activity: activity)
                    } label: {
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(activity.title)
                                Text(activity.description)
                            }
                            Spacer()
                            Text("\(activity.log.count)")
                            
                        }
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("Habits")
            .toolbar {
                Button {
                    showingAddActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddView(activities: activities)
            }
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
