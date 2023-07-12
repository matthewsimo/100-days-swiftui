//
//  AddView.swift
//  Habit
//
//  Created by Matthew Simo on 7/12/23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var activities: Activities
    
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add new activity")
            .toolbar {
                Button("Save") {
                    let item = Activity(title: title, description: description)
                    activities.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(activities: Activities())
}
