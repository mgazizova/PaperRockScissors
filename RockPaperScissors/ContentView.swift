//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Мария Газизова on 16.09.2024.
//

import SwiftUI

struct ContentView: View {
    private let moves =  ["Paper", "Rock", "Scissors"]
    
    @State private var showingScore = false
    @State private var currentChoise = Int.random(in: 0..<3)
    @State private var scoreTitle: String = ""
    @State private var score: Int = 0
    
    @State private var attempts = 0
    @State private var showingEndGame = false
    
    private func moveMade(_ index: Int) {
        if rules(
            left: moves[currentChoise],
            right: moves[index]
        ) {
            scoreTitle = "You're win!"
            score += 1
        } else {
            scoreTitle = "Not your day"
            score -= 1
        }
        attempts += 1
        attempts == 10 ? showingEndGame .toggle() :
        showingScore.toggle()
    }
    
    private func rules(left: String, right: String) -> Bool{
        if left == "Paper" && right == "Scissors" {
            return true
        }
        if left == "Rock" && right == "Paper" {
            return true
        }
        if left == "Scissors" && right == "Rock" {
            return true
        }
        return false
    }
    
    private func reset() {
        score = 0
        attempts = 0
        newMove()
    }
    
    private func newMove() {
        currentChoise = Int.random(in: 0..<3)
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color.red
                Text(moves[currentChoise])
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
            
            ZStack {
                Color.blue
                
                VStack {
                    Text("Select your move")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    
                    ForEach(0..<3) { m in
                        Button(moves[m]) {
                            moveMade(m)
                        }
                        .background(.red)
                        .foregroundStyle(.white)
                        .buttonStyle(.bordered)
                        .font(.title)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: newMove)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("The End", isPresented: $showingEndGame) {
            Button("Start new game", action: reset)
        } message: {
            Text("Your final score is \(score)")
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
