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
            let shadowOffset = 5.0
            
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: card.image.toFullPath())) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .shadow, radius: 5)
                } placeholder: {
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .shadow, radius: 5)
                }
            }
            .offset(y: isExpand ? offset : -rect.minY + offset + shadowOffset )
            .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
        }
        .frame(height: 200)
    }
}
