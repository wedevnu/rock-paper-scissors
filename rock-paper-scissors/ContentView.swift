//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by Alan Zhang on 1/22/25.
//

import SwiftUI

enum Emoji: String, CaseIterable {
    case rock = "🪨"
    case paper = "📜"
    case scissors = "✂️"
    case placeholder = ""
}

struct ContentView: View {
    @State private var userChoice: Emoji = .placeholder
    @State private var computerChoice: Emoji = .placeholder
    @State private var result: String = ""
    
    var body: some View {
        Text("Rock, Paper, Scissors!")
            .font(.headline)
            .padding(.top, 20)

        Spacer() // Ensure the text stays at the top
        
        VStack {
            Text(userChoice.rawValue)
                .font(.system(size:80))
                .padding()
            
            Picker("Select Emoji", selection: $userChoice) {
                ForEach(Emoji.allCases.filter { $0 != .placeholder }, id: \.self) { emoji in
                    Text(emoji.rawValue)
                        .font(.system(size: 40)) // Adjust size as needed
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button("Submit") {
                if userChoice != .placeholder {
                    computerChoice = Emoji.allCases.filter { $0 != .placeholder }.randomElement() ?? .placeholder
                    determineResult()
                }
            }
            .padding()
            .disabled(userChoice == .placeholder)
            
            if computerChoice != .placeholder {
                VStack {
                    Text("CPU Choice")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text(computerChoice.rawValue)
                        .font(.system(size: 80))
                }
                .padding()
            }
            
            if !result.isEmpty {
                Text(result)
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding()
            }
        }
    }
    
    private func determineResult() {
        if userChoice == computerChoice {
            result = "It's a tie!"
        } else if (userChoice == .rock && computerChoice == .scissors) ||
                    (userChoice == .paper && computerChoice == .rock) ||
                    (userChoice == .scissors && computerChoice == .paper) {
            result = "You win!"
        } else {
            result = "CPU wins!"
        }
    }
}

#Preview {
    ContentView()
}
