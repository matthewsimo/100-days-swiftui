//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Matthew Simo on 7/17/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            FilteredListView(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let s1 = Singer(context: moc)
                s1.firstName = "Taylor"
                s1.lastName = "Swift"
                
                let s2 = Singer(context: moc)
                s2.firstName = "Ed"
                s2.lastName = "Sheeran"
                
                let s3 = Singer(context: moc)
                s3.firstName = "Adele"
                s3.lastName = "Adkins"
                
                
                try? moc.save()
            }
            
            Button("Show A") {
                lastNameFilter = "A"
            }
            
            Button("Show S") {
                lastNameFilter = "S"
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
