//
//  ItemCardView.swift
//  NameCardIOS
//
//  Created by Measna on 27/11/23.
//

import SwiftUI

struct ItemCardView : View {
    
    var index: Int
    var card: Card
    @Binding var isExpand: Bool
    
    var body: some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .named("SCROLL"))
            let offset = CGFloat(index * (isExpand ? 10 : 70))
            
            ZStack(alignment: .bottomLeading) {
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: .shadow, radius: 5)
                
            }
            .offset(y: isExpand ? offset : -rect.minY + offset )
        }
        .frame(height: 200)
    }
}
