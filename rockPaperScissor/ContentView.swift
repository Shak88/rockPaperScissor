//
//  ContentView.swift
//  rockPaperScissor
//
//  Created by Shokri Alnajjar on 11/04/2022.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 300)
            .padding(.vertical, 20)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .foregroundColor(.secondary)
    }
}

extension View {
    func buttonstyle() -> some View {
        modifier(ButtonModifier())
    }
}

struct ContentView: View {
    let moves = ["rock","paper","scissor"]
    @State private var shouldWin = Bool.random()
    @State private var appSelection = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var score = 0
    @State private var currentTurn = 0
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                Spacer()
                Text("The Player should \(winOrLose(shouldWin))")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                Text("The System Selected \(moves[appSelection])")
                    .font(.subheadline.weight(.heavy))
                
                Text("Select from the options Below")
                    .font(.subheadline.weight(.heavy))
                
                Spacer()
                Button("Rock 👊") {
                    if shouldWin && moves[appSelection] == "scissor" {
                        score += 1
                        scoreTitle = "Correct"
                    } else if !shouldWin && moves[appSelection] != "scissor" {
                        score += 1
                        scoreTitle = "Correct"
                    }else {
                        scoreTitle = "Wrong"
                    }
                    refreshOptions()
                    
                }.buttonstyle()
                
                Button("Paper ✋") {
                    if shouldWin && moves[appSelection] == "rock" {
                        score += 1
                        scoreTitle = "Correct"
                    } else if !shouldWin && moves[appSelection] != "rock" {
                        score += 1
                        scoreTitle = "Correct"
                    }else {
                        scoreTitle = "Wrong"
                    }
                    refreshOptions()
                    
                }.buttonstyle()
                
                
                Button("Scissocr ✌️") {
                    if shouldWin && moves[appSelection] == "paper" {
                        score += 1
                        scoreTitle = "Correct"
                    } else if !shouldWin && moves[appSelection] != "paper" {
                        score += 1
                        scoreTitle = "Correct"
                    }else {
                        scoreTitle = "Wrong"
                    }
                    refreshOptions()
                }.buttonstyle()
                Spacer()
                
                Text("Score : \(score)")
                    .padding()
            }
        } .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }message : {
            if scoreTitle == "Wrong" {
                Text("You didn't choose the right option")
            }
            Text("Your Score is \(score)")
        }
    }
    
    func winOrLose(_ status : Bool) -> String {
        if status == true {
            return "win"
        }
        return "lose"
    }
    
    func refreshOptions() {
        showingScore = true
        
        currentTurn += 1
        if currentTurn == 10 {
            score = 0
            currentTurn = 0
        }
    }
    func askQuestion() {
        shouldWin.toggle()
        appSelection = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
