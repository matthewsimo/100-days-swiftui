//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Matthew Simo on 6/29/23.
//

import SwiftUI

struct BigTitle: ViewModifier {
    let weight: Font.Weight
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(weight))
            .foregroundColor(.white)
    }
}

extension View {
    func titleStyle(weight: Font.Weight) -> some View {
        modifier(BigTitle(weight: weight))
    }
}

struct FlagImage: View {
    
    let country:String;
    
    var body: some View {
        
        Image(country).renderingMode(.original)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 50))).shadow(radius: 5)
        
    }
}

struct ContentView: View {
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var currentFlag = -1
    @State private var scale = 0.8
    @State private var opacity = 1.0
    @State private var rotation = 0.0
    
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                .init(color: Color(red: 0.4, green: 0.31, blue: 0.64), location: 0.15),
                .init(color: Color(red: 0.92, green: 0.69, blue: 0.78), location: 0.85)
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            
            VStack {
                
                Spacer()
                
                Text("Guess the Flag")
                    .titleStyle(weight: .bold)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                            .shadow(radius: 10)
                        Text(countries[correctAnswer])
                            .titleStyle(weight: .semibold)
                            .shadow(radius: 8)
                    }
                    
                    ForEach(0..<3) { num in
                        Button {
                            currentFlag = num
                            flagTapped(num)
                            withAnimation {
                                scale = 0.8
                                opacity = 0.25
                                rotation = 360.0
                            }
                        } label: {
                            FlagImage(country: countries[num])
                        }
                        .scaleEffect(currentFlag == num ? 1.2 : scale)
                        .opacity(currentFlag == num ? 1.0 : opacity)
                        .rotation3DEffect(
                            .degrees(currentFlag == num ? rotation : 0.0),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .onAppear {
                            withAnimation {
                                scale = 1.0
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong!"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        initAnimationValues()
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func initAnimationValues() {
        currentFlag = -1
        scale = 1.0
        opacity = 1.0
        rotation = 0.0
    }
}

#Preview {
    ContentView()
}
