//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Oğuz on 30.08.2023.
//

import SwiftUI

struct FlyingNumber: View {
    
    @State private var offset: CGFloat = 0
    
    let number: Int
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle.italic())
                .foregroundColor(number < 0 ? .red : .green)
                .offset(x:0, y: offset)
                .opacity(offset != 0 ? 0 : 1)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        offset = number < 0 ? 200 : -1000
                    }
                }
        }
    }
}

struct FlyingNumber_Previews: PreviewProvider {
    static var previews: some View {
        FlyingNumber(number: 1)
    }
}
