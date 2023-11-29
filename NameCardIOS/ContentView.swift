//
//  ContentView.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("token") private var token = ""
    
    var body: some View {
        Group {
            if token.isEmpty {
                LoginView()
            } else {
                HomeView()
            }
        }
     
    }
}

#Preview {
    ContentView()
}
