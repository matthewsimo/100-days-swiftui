//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Matthew Simo on 7/7/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
