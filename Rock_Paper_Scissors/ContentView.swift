//
//  ContentView.swift
//  Rock_Paper_Scissors
//
//  Created by Alexander Adgebenro on 6/13/22.
//

import SwiftUI

struct ContentView: View {
    
    let moves = ["✊🏾","✋🏾","✌🏾"]
    
    @State private var scoreCounter = 0
    @State private var questionCount = 1
    @State private var shouldWin = Bool.random()
    @State private var ShowingResults = false
    @State private var computersChoice = Int.random(in: 0..<3)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .yellow]), startPoint: .top, endPoint: .bottom )
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Computer has played: ")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Text(moves[computersChoice])
                    .font(.system(size: 300))
                
                if shouldWin {
                    Text("Which one wins?")
                        .foregroundColor(.green)
                        .font(.title)
                } else {
                    Text("Which one loses?")
                        .foregroundColor(.red)
                        .font(.title)
                }
                
                HStack {
                    ForEach (0..<3) { number in
                        Button(moves[number]) {
                            // Handle button tap
                            play(choice: number)
                            
                        }
                        .font(.system(size: 80))
                        
                    }
                }
                
                Spacer()
                
                Text("Score: \(scoreCounter)")
                    .font(.subheadline)
                
                Spacer()
                
            }
        }
        .alert("Game Over", isPresented: $ShowingResults) {
            Button("Play Again", action: reset)
            
        } message: {
            Text ("Your score was \(scoreCounter)")
        }
    }
    func play(choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[computersChoice]
        } else {
            didWin = winningMoves[choice] == computersChoice
        }
        
        
        if didWin {
            scoreCounter += 1
        } else {
            scoreCounter -= 1
        }
        
        
        if questionCount == 10 {
            ShowingResults = true
        } else {
            computersChoice = Int.random(in: 0..<3)
            shouldWin.toggle()
            questionCount += 1
        }
        
    }
    func reset() {
        computersChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        questionCount = 0
        scoreCounter = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
