//
//  ItemDetailView.swift
//  NameCardIOS
//
//  Created by Measna on 16/2/24.
//

import SwiftUI

struct ItemDetailView : View {
    
    var label: String
    var text: String
    var icon: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 12))
                    .foregroundColor(.text)
                Text(label)
                    .font(.primary(.regular, size: 12))
                    .foregroundColor(.text)
                Spacer()
            }
            
            Text(text)
                .font(.primary(.medium))
                .foregroundColor(.text)
                .padding(.top, 2)
        }
    }
}

