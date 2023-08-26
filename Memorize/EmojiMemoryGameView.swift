//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Oğuz on 24.08.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    // Ekranda görünecek kartların düzen View'i
    private var cards: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 6), spacing: 10) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/5, contentMode: .fit)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
                    .foregroundColor(.orange)
            }
        }
        .padding(10)
    }
}





struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView()
    }
}


