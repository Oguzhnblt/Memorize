//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Oğuz on 24.08.2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable {

    
    
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // numbersOfPairsOfCards x 2 
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }

    mutating func shuffle() {
        cards.shuffle()
    }
    
    func choose(_ card: Card) {
        
    }
    
    struct Card: Equatable {
        
        static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp &&
            lhs.isMatched == rhs.isMatched &&
            lhs.content == rhs.content
        }
        
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        let content: CardContent
    }
}
