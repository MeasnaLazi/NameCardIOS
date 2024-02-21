//
//  TagView.swift
//  NameCardIOS
//
//  Created by Measna on 20/2/24.
//

import SwiftUI

struct TagView: View {
    let tag: String
    var onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text(tag)
                .font(.primary(.regular, size: 14))
                .padding(.vertical, 5)
                .padding(.leading, 8)
                .foregroundColor(.black)
                
            Button(action: onDelete) {
                Image(systemName: "xmark")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .padding(.trailing, 8)
            }
        }
        .background(.gray.opacity(0.4))
        .cornerRadius(20)
    }
}
