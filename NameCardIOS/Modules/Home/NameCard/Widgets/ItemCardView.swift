//
//  ItemCardView.swift
//  NameCardIOS
//
//  Created by Measna on 27/11/23.
//

import SwiftUI

struct ItemCardView : View {
    
    var card: Card
    
    var body: some View {
        HStack {
            Spacer()
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
            Spacer()
        }
    }
}
