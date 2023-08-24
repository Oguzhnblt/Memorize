//
//  ContentView.swift
//  Memorize
//
//  Created by Oğuz on 24.08.2023.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["⚡️","😇","🛢️","🤬","💫","🤡","☠️","👽","🤖","🍭","🫡","🥶"]
    
    var body: some View {
        ScrollView {
            cards
        }
        .padding()
    }
    
    // Ekranda görünecek kartların View'i
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]){
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        
    }
   
    struct CardView: View {
        let content: String
        @State var isFaceUp = true
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(content).font(.largeTitle)
                }
                base.fill().opacity(isFaceUp ? 0 : 1)
                
            }
            .onTapGesture {
                isFaceUp.toggle()
            }
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
