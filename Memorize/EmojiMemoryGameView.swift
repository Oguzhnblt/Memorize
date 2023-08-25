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
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing: 0)],spacing: 0){
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
        
    }
   
    struct CardView: View {
        
        let card: MemoryGame<String>.Card
        
        init(_ card: MemoryGame<String>.Card) {
            self.card = card
        }
        
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(card.content)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                    
                }
                base.fill().opacity(card.isFaceUp ? 0 : 1)
                  
            }
        }
    }
    
    
    
    struct EmojiMemoryGameView_Previews: PreviewProvider {
        static var previews: some View {
            EmojiMemoryGameView()
        }
    }
}
