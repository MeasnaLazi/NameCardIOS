//
//  HomeView.swift
//  NameCardIOS
//
//  Created by Measna on 15/2/24.
//

import SwiftUI

struct HomeView : View {
    
    init() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().unselectedItemTintColor = .unselect
    }
    
    var body: some View {
        TabView {
            NameCardView()
                .tabItem {
                    Label("Card", systemImage: "creditcard.circle")
                }
            EventView()
                .tabItem {
                    Label("Event", systemImage: "circle.hexagongrid.circle")
                }
            DealView()
                .tabItem {
                    Label("Deal", systemImage: "dollarsign.circle")
                }
            NotificationView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.circle")
                }
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "list.bullet.circle")
                }
        }
        .accentColor(.app)
    }
    
}
