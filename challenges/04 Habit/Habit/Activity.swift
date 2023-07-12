//
//  Activity.swift
//  Habit
//
//  Created by Matthew Simo on 7/12/23.
//

import Foundation


struct Activity: Identifiable, Codable, Equatable {
    struct LogItem: Identifiable, Codable, Equatable {
        var id = UUID()
        let date: Date
        
        var formattedDate: String {
            date.formatted(date: .abbreviated, time: .omitted)
        }
    }
    
    var id = UUID()
    
    let title: String
    let description: String
    
    var log: [LogItem] = [LogItem]()
    
    mutating func addToLog() {
        let date = Date.now
        self.log.append(LogItem(date: date))
    }
}
