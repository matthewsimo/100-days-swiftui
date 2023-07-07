//
//  ExpenseItemView.swift
//  iExpense
//
//  Created by Matthew Simo on 7/7/23.
//

import SwiftUI

struct ExpenseItemView: View {
    
    var item: ExpenseItem
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading){
                
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            
            Text(item.amount, format: asCurrency)
                .foregroundColor(amountColor(amount: item.amount))
                .bold()
            
        }
    }
    
    func amountColor(amount: Double) -> Color {
        return amount > 100 ?
            .red
        : amount > 10 ?
            .orange
        : .primary
    }
    
}

#Preview {
    ExpenseItemView(item: ExpenseItem(name: "Test Name", type: "Personal", amount: 30.0))
}
