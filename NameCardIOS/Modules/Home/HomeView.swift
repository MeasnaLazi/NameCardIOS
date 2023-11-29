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
    
    private func onExpandButtonClick() {
        withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)){
            isExpand = false
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("CARDS")
                .titleLabelStyle()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: isExpand ? .leading : .center)
                .overlay(alignment: .trailing) {
                    expandButton
                }
            ScrollView(.vertical,  showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(_viewModel.cards) { card in
                        itemCardView(card: card)
                    }
                }
                .padding([.horizontal, .top])
                .overlay {
                   invisibleOverlayView
                }
                .padding(.top, isExpand ? 30 : 0)
                
                createButton
            }
            .coordinateSpace(name: "SCROLL")
            .offset(y: isExpand ? 0 : 30)
            
        }
        .padding([.horizontal, .top])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(isShowDetail ? 0 : 1)
        .overlay {
            if let currentCard = currentCard, isShowDetail {
                DetailView(card: currentCard, showDetailCard: $isShowDetail, animation: animation)
            }
        }
        .onAppear() {
            onViewAppear()
        }
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
    
    private var expandButton : some View {
        Button {
            onExpandButtonClick()
        } label: {
            Image(systemName: "chevron.down")
                .foregroundColor(.primary)
                .fontWeight(.bold)
                .font(.system(size: 18))
                .padding(12)
                .background(Color.bgNavMenuItem, in: Circle())
        }
        .rotationEffect(.init(degrees: isExpand ? 180 : 0))
        .offset(x: isExpand ? 10 : 15)
        .opacity(isExpand ? 1 : 0)
        .padding(.trailing, 12)
        .padding(.bottom, 8)
    }
    
    private var createButton : some View {
        Button {
            // TODO
        } label: {
            Image(systemName: "plus.diamond")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(12)
                .background(Color.primary, in: Circle())
                .shadow(color: .white, radius: 5.0)
        }
        .rotationEffect(.init(degrees: isExpand ? 180 : 0))
        .scaleEffect(isExpand ? 0.01 : 1)
        .opacity(!isExpand ? 1 : 0)
        .frame(height: isExpand ? 0 : nil)
        .padding(.bottom, isExpand ? 0 : 60)
    }
}


