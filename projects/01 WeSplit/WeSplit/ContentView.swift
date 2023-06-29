//
//  ContentView.swift
//  WeSplit
//
//  Created by Matthew Simo on 6/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var tipValue: Double {
        checkAmount / 100 * Double(tipPercentage)
    }
    var grandTotal: Double {
        checkAmount + tipValue
    }
    var amount: Double {
        grandTotal / Double(numberOfPeople + 2)
    }
    
    var asCurrency : FloatingPointFormatStyle<Double>.Currency {
       FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    var body: some View {
        NavigationView {
            Form {
            
                Section {
                    TextField("Amount", value: $checkAmount, format: asCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section {
                    Text(amount, format: asCurrency)
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(grandTotal, format: asCurrency)
                } header: {
                    Text("Grand total:")
                }

            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
