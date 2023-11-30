//
//  ItemDetailView.swift
//  NameCardIOS
//
//  Created by Measna on 27/11/23.
//

import SwiftUI

struct ItemDetailView : View {
    
    var label: String
    var text: String
    var icon: String
    var actionOpen: DetailView.ActionOpen
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(actionOpen == .none ? .textSecondary : .text)
            Text(label)
                .font(.primary(.regular, size: 14))
                .foregroundColor(actionOpen == .none ? .textSecondary : .text)
            Spacer()
            Text(text)
                .font(.primary(.medium, size: 14))
                .foregroundColor(.text)
        }
        .onTapGesture {
            actionOpen.open(text: text)
        }
    }
}
