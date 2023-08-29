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
            HStack {
                score
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
            CardView(card)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
                .padding(4)
        }
        .frame(minHeight: 750)
        .foregroundColor(.orange)
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        return 0 
    }
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView()
    }
}


