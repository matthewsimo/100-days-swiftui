//
//  ActivityView.swift
//  Habit
//
//  Created by Matthew Simo on 7/12/23.
//

import SwiftUI

struct ActivityView: View {
    @StateObject var activities: Activities
    @State var activity: Activity
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                Text(activity.description).padding(.bottom)
                
                if activity.log.isEmpty {
                    Text("This activity hasn't been logged yet")
                        .font(.subheadline)
                } else {
                    VStack(alignment: .leading) {
                        
                        Text("This activity has been logged \(activity.log.count) time\(activity.log.count > 1 ? "s" : "")")
                            .font(.subheadline)
                            .padding(.vertical)
                        
                        ForEach(Array(activity.log.enumerated()), id: \.offset) { index, logItem in
                            VStack (alignment: .leading) {
                                Text("Log #\(index + 1)")
                                    .font(.headline)
                                Text("\(logItem.formattedDate)")
                                    .font(.title2)
                            }
                            .padding(.vertical)
                        }
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .toolbar {
            Button("Log activity") {
                let index = activities.items.firstIndex(of: activity)
                activity.log.append(Activity.LogItem(date: Date.now))
                if index != nil {
                    activities.items[index!] = activity
                }
            }
            
        }
        .navigationTitle(activity.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    var activityOne = Activity(title: "Activity Title 0", description: "Activity Description 0", log: [Activity.LogItem(date: Date.now)])
    var activityTwo = Activity(title: "Activity Title 1", description: "Activity Description 1")
    var activities = Activities()
    if activities.items.isEmpty {
        activities.items.append(activityOne)
        activities.items.append(activityTwo)
    }
    return ActivityView( activities: activities, activity: activityOne)
}
