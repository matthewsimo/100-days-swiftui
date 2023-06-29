//
//  ContentView.swift
//  01 Unit Converter
//
//  Created by Matthew Simo on 6/29/23.
//

import SwiftUI


let units = [
    UnitVolume.liters,
    UnitVolume.milliliters,
    UnitVolume.kiloliters,
    UnitVolume.cups,
    UnitVolume.pints,
    UnitVolume.quarts,
    UnitVolume.gallons,
]

extension UnitVolume {
    var display: LocalizedStringKey { LocalizedStringKey(symbol) }
}


struct ContentView: View {
    @State private var inValue = 1.0
    @State private var inUnits: UnitVolume = .liters
    @State private var outUnits: UnitVolume = .pints
    
    var outValue: Double {
        
        let out = Measurement(value: inValue, unit: inUnits).converted(to: outUnits)
        
        return out.value
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input Value", value: $inValue, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("Input Units", selection: $inUnits) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    
                    
                } header: {
                    Text("Input")
                }
                
                Section {
                    Picker("Output Units", selection: $outUnits) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                } header: {
                    Text("Output")
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Text(outValue, format: .number)
                        
                        Text(outUnits.symbol)
                    }
                }.onTapGesture {
                    UIPasteboard.general.setValue(String(outValue), forPasteboardType: "public.plain-text")
                }
            }
            .navigationTitle("Volume Converter")
        }
    }
}

#Preview {
    ContentView()
}
