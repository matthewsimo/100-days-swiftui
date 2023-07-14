//
//  ContentView.swift
//  Bookworm
//
//  Created by Matthew Simo on 7/14/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
                Text("hi")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
