//
//  ContentView.swift
//  Moonshot
//
//  Created by Matthew Simo on 7/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showAsGrid = false
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let listColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    let gridColumns = [
        GridItem(.adaptive(minimum: .infinity))
    ]
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: showAsGrid ? listColumns : gridColumns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            if showAsGrid {
                                MissionPreviewGrid(mission: mission)
                            } else {
                                MissionPreviewList(mission: mission)
                            }
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    showAsGrid.toggle()
                } label: {
                    Image(
                        systemName: showAsGrid
                        ? "rectangle.grid.1x2.fill"
                        : "square.grid.2x2.fill"
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
