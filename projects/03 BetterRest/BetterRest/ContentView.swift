//
//  ContentView.swift
//  BetterRest
//
//  Created by Matthew Simo on 6/30/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    //    @State private var title = ""
    //    @State private var message = ""
    
    var results: (String, String) {
        var title = ""
        var message = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents(([.hour, .minute]), from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmount, coffee: Int64(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            title = "Your ideal bedtime is..."
            message = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            title = "Error"
            message = "Sorry, there was a problem calculating your bedtime."
            
        }
        return (title, message)
        
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 6
        components.minute = 15
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Form {
                    Section {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    } header: {
                        Text("When to wake?")
                            .font(.headline)
                    }
                    
                    Section {
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    } header: {
                        Text("How much sleep?")
                            .font(.headline)
                    }
                    
                    
                    Section {
                        Picker("Number of cups", selection: $coffeeAmount) {
                            ForEach(1...20, id: \.self) {
                                Text($0, format: .number)
                            }
                        }
                    } header: {
                        Text("Daily cups of coffee")
                            .font(.headline)
                    }
                }
                
                Spacer()
                Group {
                    Text(results.0).font(.subheadline)
                    Text(results.1).font(.headline)
                }
                
            }
            .navigationTitle("BetterRest")
        }
    }
}

#Preview {
    ContentView()
}
