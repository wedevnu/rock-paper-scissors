//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by Alan Zhang on 1/22/25.
//  Contributor: Nicole Contreras
//

import SwiftUI

enum Move: String, CaseIterable {
    case rock = "🪨"
    case paper = "📜"
    case scissors = "✂️"
}

struct ContentView: View {
    // State variables for user choice, computer choice, and result message
    @State private var userChoice: Move = .rock
    @State private var computerChoice: Move = .rock
    @State private var result: String = ""

    var body: some View {
        VStack {
            // Title
            Text("Rock, Paper, Scissors!")
                .font(.largeTitle)
                .padding(.top, 20)

            Spacer() // Pushes everything upward

            // Computer's Choice Section
            if result != "" {
                VStack {
                    Text("CPU Choice")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text(computerChoice.rawValue)
                        .font(.system(size: 80))
                }
                    .padding()

            }
        
            // Game Result Section
            if !result.isEmpty {
                Text(result)
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding()
            }

            Spacer()
        }
        .padding()
        
            // User Choice Section
            VStack {
                Text("Your Choice")
                    .font(.headline)
                    .padding(.bottom, 5)
                Text(userChoice.rawValue)
                    .font(.system(size: 80))
                    .padding()
            }
            

            // Picker for selecting the user's move
            Picker("Select Emoji", selection: $userChoice) {
                ForEach(Move.allCases, id: \.self) { move in
                    Text(move.rawValue)
                        .font(.system(size: 40)) // Display the emoji in picker
                }
            }
            .pickerStyle(.segmented)
            .padding()

            // Submit Button
            Button("Submit") {
                computerChoice = GameLogic.randomMove()
                result = GameLogic.determineWinner(player: userChoice, computer: computerChoice)
            }
            .padding()
    }
}

#Preview {
    ContentView()
}

