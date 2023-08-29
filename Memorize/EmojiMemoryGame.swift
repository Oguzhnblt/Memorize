//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Oğuz on 25.08.2023.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    
    private static let emojis = ["⚡️","😇","🛢️","🤬","💫","🤡","☠️","👽","🤖","🍭","🫡","🥶","🌈","🍕","🚀","🎉","🍔","🌊"]

    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 2) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            else {
                return "⁉️"
            }
        }
    }
      
   @Published private var model = createMemoryGame()
    
    var score: Int {
        model.score
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card ) {
        model.choose(card)
    }
}
