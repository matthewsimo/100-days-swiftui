//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Matthew Simo on 6/30/23.
//

import SwiftUI

enum Move: String, CaseIterable {
    case rock = "Rock", paper = "Paper", scissors = "Scissors"
    
    func wins() -> Move {
        switch self {
        case .rock:
            return .scissors
        case .paper:
            return .rock
        case .scissors:
            return .paper
        }
    }
    
    func loses() -> Move {
        switch self {
        case .rock:
            return .paper
        case .paper:
            return .scissors
        case .scissors:
            return .rock
        }
    }
}

struct MoveButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 25, height: 15)))
    }
}

extension View {
    func moveButton() -> some View {
        modifier(MoveButton())
    }
}

struct ContentView: View {
    @State private var currentScore: Int = 0
    @State private var currentRound: Int = 1
    
    @State private var roundMove: Move = Move.allCases.randomElement()!
    @State private var shouldWin: Bool = Bool.random()
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                Text("Score: \(currentScore) Round: \(currentRound)")
                Text("I choose \(roundMove.rawValue)")
                Text(shouldWin ? "Try to win!" : "Try to lose!")
            }
            Spacer()
            if currentRound > 10 {
                VStack{
                    Text("Game Over!")
                    Button("Reset") {
                        initGame()
                    }
                }
            } else {
                HStack(spacing: 50) {
                    Button("🪨") {
                        handleClick(move: .rock)
                    }.moveButton()
                    Button("🗞️") {
                        handleClick(move: .paper)
                    }.moveButton()
                    Button("✂️") {
                        handleClick(move: .scissors)
                    }.moveButton()
                }
                .padding()
                .font(.system(size: 50))
            }
            Spacer()
        }
        .padding()
    }
    
    func initGame() -> Void {
        currentScore = 0
        currentRound = 1
        roundMove = Move.allCases.randomElement()!
        shouldWin = Bool.random()
    }
    
    func handleClick(move: Move) -> Void {
        guard currentRound <= 10 else {
            print("game over")
            return
        }
        
        let toScore = shouldWin ? roundMove.loses() : roundMove.wins()
        
        if(move == toScore) {
            currentScore += 1
        }
        
        currentRound += 1
        roundMove = Move.allCases.randomElement()!
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
