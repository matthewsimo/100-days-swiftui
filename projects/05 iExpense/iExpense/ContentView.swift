//
//  ContentView.swift
//  iExpense
//
//  Created by Matthew Simo on 7/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    var body: some View {
        NavigationView {
            
            List {
                
                if personalExpenses.count > 0 {
                    
                    Section("Personal") {
                        
                        ForEach(personalExpenses) { item in
                            ExpenseItemView(item: item)
                        }
                        .onDelete(perform: removePersonalItems)
                    }
                }
                
                if businessExpenses.count > 0 {
                    Section("Business") {
                        ForEach(businessExpenses) { item in
                            ExpenseItemView(item: item)
                        }
                        .onDelete(perform: removeBusinessItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            
        }
    }
    
    func removeItems(at offsets: IndexSet, in items: [ExpenseItem] ) {
        var normalizedOffsets = IndexSet()
        for offset in offsets {
            let item = items[offset]
            if let index = expenses.items.firstIndex(of: item) {
                normalizedOffsets.insert(index)
            }
        }
        expenses.items.remove(atOffsets: normalizedOffsets)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: personalExpenses)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: businessExpenses)
    }
}

#Preview {
    ContentView()
}
