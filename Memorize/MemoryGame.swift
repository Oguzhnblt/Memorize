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
    
    var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else {
            return
        }
        
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
            }
            indexOfTheOneAndOnlyFaceUpCard = nil
        } else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
        
        cards[chosenIndex].isFaceUp = true
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        var id: String
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
    }
}
