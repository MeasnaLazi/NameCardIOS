//
//  HomeView.swift
//  NameCardIOS
//
//  Created by Measna on 27/11/23.
//

import SwiftUI
import Combine
import VisionKit

struct HomeView : View {

    @ObservedObject private var _viewModel = VMFactory.shared.homeViewModel
    
    @State private var _currentCard: Card!
    @State private var _isShowDetail: Bool = false
    @State private var _isExpand: Bool = false
    @State private var _isSearch: Bool = false
    @State private var _isSearchMode = false
    @State private var _searchText = ""
    @State private var _page: Int = 1
    @State private var _timerCancellable: AnyCancellable?
    
    @State private var _isOpenCamera = false
    @State private var _isOpenDetectView  = false
    @State private var _imageDetect: UIImage?
    
    @State private var _isOpenMyQRCode = false
    
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
            _isExpand = true
            _isSearch = true
        }
    }
    
    private func onItemCardViewClick(card: Card) {
        withAnimation(.easeInOut(duration: 0.35)) {
            _currentCard = card
            _isShowDetail = true
        }
    }
    
    private func _startTimerSearch() {
        if let timerCancellable = _timerCancellable {
            timerCancellable.cancel()
        }
        
        _timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self._viewModel.onSearch(search: self._searchText, page: self._page)
                _timerCancellable?.cancel()
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
                                .padding(.bottom, _isExpand ? 130 : 0)
                            }
                            .coordinateSpace(name: "SCROLL")
                        }
                        .overlay {
                           invisibleOverlayView
                        }
                    }
                    .padding([.horizontal, .top])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(_isShowDetail ? 0 : 1)
                    .overlay {
                        if let currentCard = _currentCard, _isShowDetail {
                            DetailView(card: currentCard, animation: animation, showDetailCard: $_isShowDetail)
                                .onDisappear() {
                                    _isSearch = true
                                }
                        }
                    }
                    .onAppear() {
                        onViewAppear()
                    }

                    createButton
                        .accessibilityIdentifier("createButton")
                    
                    HStack {}.sheet(isPresented: $_isOpenMyQRCode) {
                        MyQRCodeView()
                    }
                }
            }
            .navigationBarItems(leading: Text("Wallet").titleLabelStyle(), trailing: profileMenu)
            .toolbar(_isShowDetail ? .hidden : .visible, for: .navigationBar)
            .sheet(isPresented: $_isOpenCamera,onDismiss: {
                print("images: \(String(describing: _imageDetect?.size))")
                _isOpenDetectView = true
            }) {
                WeScanView(
                    resultAction: { result in
                        
                        self._isOpenCamera = false
                        
                        switch (result) {
                        case .success(let imageResult):
                            _imageDetect = imageResult.croppedScan.image
                        
                        case .failure(let err):
                            print("err: \(err)")
                        }
                        
                    }, cancelAction: {
                        print("cancel action")
                    })
            }
            .sheet(isPresented: $_isOpenDetectView) {
                DetectView(image: $_imageDetect)
            }
        }
       
        .searchable(text: $_searchText, isPresented: $_isSearch)
        .onChange(of: _isSearch, { oldValue, newValue in
            if !newValue {
                self._page = 1
                self._searchText = ""
                self._viewModel.onSearchClose()
            }
            if !_isShowDetail {
                self._isExpand = newValue
            }
        })
        .onChange(of: _searchText) { oldValue, newValue in
            if newValue.isEmpty {
                self._page = 1
            }
            self._startTimerSearch()
        }
    }
    
    
    @ViewBuilder
    private func itemCardView(card:Card) -> some View {
        Button(action: {
            onItemCardViewClick(card: card)
        }, label: {
            Text("") // this for allow whole `itemCardView` visible to XCUITest 🤦‍♂️
            if _currentCard?.id == card.id && _isShowDetail {
                ItemCardView(index: getIndex(card: card), card: card, isExpand: $_isExpand)
                    .opacity(0)
            } else {
                ItemCardView(index: getIndex(card: card), card: card, isExpand: $_isExpand)
                    .matchedGeometryEffect(id: card.id, in: animation)
            }
        })
        .accessibilityIdentifier(card.id)
    }
    
    private var invisibleOverlayView : some View {
        Rectangle()
            .fill(.black.opacity(_isExpand ? 0 : 0.01))
            .onTapGesture {
                onInvisibleOverlayViewClick()
            }
    }
    
    private var createButton : some View {
        
        Button {
            // TODO
            _isOpenCamera = true
        } label: {
            Image(systemName: "rectangle.badge.plus")
                .font(.system(size: 20))
                .padding(18)
                .foregroundColor(.white)
                .background(Color.primary)
                .clipShape(Circle())
                .shadow(color: .shadow, radius: 5, x: 0, y: 5)
            
        }
        .rotationEffect(.init(degrees: _isExpand ? 180 : 0))
        .scaleEffect(_isExpand ? 0.01 : 1)
        .opacity(!_isExpand ? 1 : 0)
        .frame(height: _isExpand ? 0 : nil)
        .padding()
    }
    
    private var profileMenu : some View {
        Menu {
            Button {
                self._isOpenMyQRCode = true
            } label: {
                createMenuItem(label: "My Code", icon: "qrcode")
            }
            
            Divider()
            
            Button {
                
            } label: {
                createMenuItem(label: "Profile", icon: "person")
            }
            Button {
                
            } label: {
                createMenuItem(label: "Setting", icon: "gearshape")
            }
        
            Divider()
            
            Button(role: .destructive) {
                
            } label: {
                createMenuItem(label: "Logout", icon: "rectangle.portrait.and.arrow.right")
            }

        } label: {
            createMenuItem(label: "Lazi", icon: "person.crop.circle")
        }
    }
    
    private func createMenuItem(label: String, icon: String) -> some View {
        return HStack {
            Text(label)
                .font(.primary(.regular))
                .foregroundColor(.text)
            Image(systemName: icon)
                .foregroundColor(.primary)
        }
    }
}

