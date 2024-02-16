//
//  HomeView.swift
//  NameCardIOS
//
//  Created by Measna on 15/2/24.
//

import SwiftUI

struct HomeView : View {
    
    @State private var selectedTab = "0"
    
    init() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().unselectedItemTintColor = .unselect
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "Inter-Regular", size: 10)! ], for: .normal)
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                NameCardView()
                    .tabItem {
                        Label("Card", systemImage: "creditcard.circle")
                    }
                    .tag("0")
                EventView()
                    .tabItem {
                        Label("Event", systemImage: "circle.hexagongrid.circle")
                    }
                    .tag("1")
                DealView()
                    .tabItem {
                        Label("Deal", systemImage: "dollarsign.circle")
                    }
                    .tag("2")
                NotificationView()
                    .tabItem {
                        Label("Notifications", systemImage: "bell.circle")
                    }
                    .tag("3")
                MenuView()
                    .tabItem {
                        Label("Menu", systemImage: "list.bullet.circle")
                    }
                    .tag("4")
            }
            .accentColor(.app)
            
            VStack {
                Spacer()
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(.border)
                    .padding(.bottom, 60)
            }
        }
    }
}
