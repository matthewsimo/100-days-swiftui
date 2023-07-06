//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Matthew Simo on 7/6/23.
//

import SwiftUI


struct Question: Identifiable {
    let id = UUID()
    let multiplier: Int
    let multiplicand: Int
    
    var answered: Int = 0
    
    var product: Int {
        multiplier * multiplicand
    }
    
    var prompt: String {
        "What is \(multiplier) * \(multiplicand)?"
    }
    
    var isCorrect: Bool {
        product == answered
    }
}


struct SummaryView: View {
    var questions: [Question]
    var totalCount: Int
    
    var body: some View {
        
        let correctQuestions = questions.filter{ q in
            q.isCorrect
        }
        
        let correctCount = correctQuestions.count
        let summary = correctCount == totalCount ? (
            "Amazing job!"
        ) : Double(correctCount / totalCount) < 0.7 ? (
            "Keep at it!"
        ) : (
            "Good work!"
        )
        
        VStack {
            
            List(questions) { question in
                HStack{
                    
                    Text(question.prompt)
                    Spacer()
                    Text(question.answered, format: .number)
                    Spacer()
                    Text(question.isCorrect ? "Correct!" : "Incorrect")
                        .bold()
                        .foregroundColor(question.isCorrect ? .green : .red)
                    
                }
            }
            
            VStack {
                Text("\(correctCount) of \(totalCount) correct")
                Text(summary)
            }
            
        }
    }
}



struct ContentView: View {
    
    
    private let questionCountOptions = [5, 10, 20]
    
    @FocusState private var isFocused: Bool
    
    @State private var isGameStarted = false
    @State private var currentTable = 5
    @State private var currentQuestionCount = 5
    
    @State private var currentQuestionNum = 0
    @State private var currentAnswer = 0.0
    @State private var currentQuestion: Question = Question(multiplier: Int.random(in: 2...12), multiplicand: Int.random(in: 1...12))
    @State private var completedQuestions: [Question] = []
    
    
    @ViewBuilder var gameView: some View {
        
        if currentQuestionNum > currentQuestionCount {
            
            SummaryView(questions: completedQuestions, totalCount: currentQuestionCount)
            
        } else {
            
            Form {
                
                Section("Question: \(currentQuestionNum) of \(currentQuestionCount)") {
                    
                    Text(currentQuestion.prompt)
                    TextField("Answer", value: $currentAnswer, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Button(currentQuestionNum == currentQuestionCount ? "finish" : "next") {
                        nextQuestion()
                    }
                }
                
            }
            
        }
    }
    
    var body: some View {
        
        
        NavigationView {
            VStack {
                if isGameStarted  {
                    gameView
                } else {
                    
                    Form {
                        
                        Section("Which table do you want to practice?") {
                            Stepper("Table: \(currentTable)", value: $currentTable, in: 2...12, step: 1)
                        }
                        
                        Section("How many questions?") {
                            Picker("Question Count", selection: $currentQuestionCount) {
                                ForEach(questionCountOptions, id: \.self) {
                                    Text($0, format: .number)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                }
            }
            .navigationTitle("Multiplication Tables")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    Spacer()
                    
                    isGameStarted ? AnyView(
                        Button("Restart") {
                            endGame()
                        }
                    ) : AnyView(
                        Button("Start") {
                            startGame()
                        }
                    )
                    
                }
            }
            
        }
    }
    
    func startGame() {
        print("start game")
        
        nextQuestion()
        isGameStarted = true
    }
    
    func endGame() {
        print("end game")
        
        isGameStarted = false
        currentQuestionNum = 0
        completedQuestions = []
    }
    
    func nextQuestion() {
        print("next question")
        
        // Save this question state
        if( isGameStarted ) {
            currentQuestion.answered = Int(currentAnswer)
            completedQuestions.append(currentQuestion)
        }
        
        // Reset
        currentAnswer = 0.0
        currentQuestion = Question(multiplier: currentTable, multiplicand: Int.random(in: 1...12))
        
        // Increment turn
        isFocused = false
        currentQuestionNum += 1
    }
}

#Preview {
    ContentView()
}
