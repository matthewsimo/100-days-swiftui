//
//  ActivityView.swift
//  Habit
//
//  Created by Matthew Simo on 7/12/23.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activities = Activities()
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
                        
                        List  {
                            ForEach(activity.log) { logItem in
                                Text("Completed on \(logItem.formattedDate)")
                            }
                        }
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .toolbar {
            Button("Log activity") {
                activity.addToLog()
            }
            
            
            
        }
        .navigationTitle(activity.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ActivityView( activities: Activities(), activity: Activity(title: "Activity Title", description: "Activity Description"))
}
