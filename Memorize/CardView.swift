//
//  CardView.swift
//  Memorize
//
//  Created by Oğuz on 26.08.2023.
//

import SwiftUI

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        
        if card.isFaceUp || !card.isMatched {
            
            Pie(endAngle: .degrees(240))
                .opacity(Constants.Pie.opacity)
                .overlay(cardContents.padding(Constants.Pie.inset))
                .cardify(isFaceUp: card.isFaceUp)
                .transition(.scale)
        }
        else {
            Color.clear
        }
    }
    
    
    var cardContents: some View {
        Text(card.content) // HER BİR KARTIN İÇERĞİNİN ÖZELLİKLERİ
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched) // Value : kartların eşleşme durumu dışında bu animasyonu devam ettirmemesi için
    }
    
    private struct Constants {
        
        static let inset: CGFloat = 5
        
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
}


extension Animation {
    
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(MemoryGame<String>.Card(id: "t", content: "ef"))
    }
}
