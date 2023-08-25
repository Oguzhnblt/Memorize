//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Oğuz on 24.08.2023.
//

import SwiftUI


class EmojiMemoryGameViewModel: ObservableObject {
    
    private static let emojis = ["⚡️","😇","🛢️","🤬","💫","🤡","☠️","👽","🤖","🍭","🫡","🥶"]
    
    
    private static func createMemoryGame() -> EmojiMemoryGame<String> {
        return EmojiMemoryGame(numberOfPairsOfCards: 12) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            else {
                return "⁉️"
            }
        }
    }
    
   @Published private var model = createMemoryGame()
    
    
    var cards: Array<EmojiMemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: EmojiMemoryGame<String>.Card ) {
        model.choose(card)
    }
}
