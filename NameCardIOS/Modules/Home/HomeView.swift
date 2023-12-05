//
//  HomeView.swift
//  NameCardIOS
//
//  Created by Measna on 27/11/23.
//

import SwiftUI

struct HomeView : View {

    @ObservedObject private var _viewModel = HomeViewModel()
    @State var isExpand: Bool = false
    @State var currentCard: Card!
    @State var isShowDetail: Bool = false
    
    @State private var _searchText = ""
    @State private var _isSearchMode = false
    
    @Namespace var animation

    private func onViewAppear() {
        _viewModel.onViewAppear()
    }
    
    private func getIndex(card: Card) -> Int {
        return _viewModel.cards.firstIndex { item in
            return item.id == card.id
        } ?? 0
    }
    
    private func onInvisibleOverlayViewClick() {
        withAnimation(.easeOut(duration: 0.35)) {
            isExpand = true
        }
    }
    
    private func onItemCardViewClick(card: Card) {
        withAnimation(.easeInOut(duration: 0.35)) {
            currentCard = card
            isShowDetail = true
        }
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                switch _viewModel.state {
                case .initial:
                    Text("")
                case .loading:
                    LoadingView()
                case .fetched:
                    Text("")
                case .fail:
                    Text("")
                }
                
                ZStack(alignment: .bottomTrailing) {
                    VStack(spacing: 0) {
                        VStack {
                            ScrollView(.vertical,  showsIndicators: false) {
                                VStack(spacing: 0) {
                                    ForEach(_viewModel.cards) { card in
                                        itemCardView(card: card)
                                    }
                                }
                                .padding([.horizontal, .top])
                            }
                            .coordinateSpace(name: "SCROLL")
                        }
                        .overlay {
                           invisibleOverlayView
                        }
                    }
                    .padding([.horizontal, .top])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(isShowDetail ? 0 : 1)
                    .overlay {
                        if let currentCard = currentCard, isShowDetail {
                            DetailView(card: currentCard, animation: animation, showDetailCard: $isShowDetail)
                        }
                    }
                    .onAppear() {
                        onViewAppear()
                    }

                    createButton
                }
            }
            .navigationBarItems(leading: Text("CARDS").titleLabelStyle())
        }
        .searchable(text: $_searchText, isPresented: $isExpand)
    }
    
    
    @ViewBuilder
    private func itemCardView(card:Card) -> some View {
        Group {
            if currentCard?.id == card.id && isShowDetail {
                ItemCardView(index: getIndex(card: card), card: card, isExpand: $isExpand)
                    .opacity(0)
            } else {
                ItemCardView(index: getIndex(card: card), card: card, isExpand: $isExpand)
                    .matchedGeometryEffect(id: card.id, in: animation)
            }
        }
        .onTapGesture {
            onItemCardViewClick(card: card)
        }
    }
    
    private var invisibleOverlayView : some View {
        Rectangle()
            .fill(.black.opacity(isExpand ? 0 : 0.01))
            .onTapGesture {
                onInvisibleOverlayViewClick()
            }
    }
    
    private var createButton : some View {
        
        Button {
            // TODO
            
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 20))
                .padding(18)
                .foregroundColor(.white)
                .background(Color.primary)
                .clipShape(Circle())
                .shadow(color: .shadow, radius: 5, x: 0, y: 5)
            
        }
        .rotationEffect(.init(degrees: isExpand ? 180 : 0))
        .scaleEffect(isExpand ? 0.01 : 1)
        .opacity(!isExpand ? 1 : 0)
        .frame(height: isExpand ? 0 : nil)
        .padding()
    }
}


