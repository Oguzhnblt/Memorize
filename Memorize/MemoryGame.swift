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
            cards.append(Card(id: "\(pairIndex + 1)b", content: content))
            cards.append(Card(id: "\(pairIndex + 1)a", content: content))
        }
    }
    
    mutating func choose (_ card: Card) {
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0  // FIXME: bogus!
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        var id: String
        
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        let content: CardContent
    }
}
