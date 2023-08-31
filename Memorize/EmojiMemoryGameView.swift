//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Oğuz on 24.08.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    
    private let aspectRatio: CGFloat = 2/3
    
    
    var body: some View {
        VStack {
            cards
                .padding(.bottom, -90)
            HStack {
                score
                Spacer()
                deck
                Spacer()
                shuffle
            }
        }
        .padding()
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil) // Skor yazılırken animasyonu durdurma (opsiyonel)
    }
    
    
    // Ekranda görünecek kartların düzen View'i
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                    .padding(4)
            }
        }
        .frame(minHeight: 750)
        .foregroundColor(.orange)
    }
    
    // MARK: CARDS
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { card in
            return !isDealt(card)
        }
    }
    
    // MARK: DECK
    
    @State private var isDeckVisible = true
    @Namespace private var dealingNamespace

    private let deckWidth: CGFloat = 50
    
    private var deck: some View {
        ZStack {
            if isDeckVisible {
                ForEach(undealtCards) { card in
                    CardView(card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                }
                Text(" Deal Cards")
                    .font(.bold(.footnote)())
                    .foregroundColor(.white)
                    .position(x: deckWidth / 2, y: deckWidth / (2 * aspectRatio))
                    .animation(.linear, value: 0)
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1)) {
                for card in viewModel.cards {
                    dealt.insert(card.id)
                }
                isDeckVisible = false
            }
        }
        .foregroundColor(.orange)
    }
    
    // MARK: SCORE
    
    @State private var lastScoreChange: (Int, causedByCardId: String) = (0, "")
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView()
    }
}


