//
//  ItemDetailView.swift
//  NameCardIOS
//
//  Created by Measna on 27/11/23.
//

import SwiftUI

struct ItemDetailView : View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
            Text("First Name")
                .font(.primary(.regular))
            Spacer()
            Text("Lazi")
                .font(.primary(.medium))
        }
    }
}
