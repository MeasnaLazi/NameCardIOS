//
//  HomeView.swift
//  NameCardIOS
//
//  Created by Measna on 27/11/23.
//

import SwiftUI
import Combine
import VisionKit

struct NameCardView : View {

    @ObservedObject private var viewModel = VMFactory.shared.nameCardViewModel
    
    @State private var searchText = ""
    @State private var page: Int = 1
    @State private var timerCancellable: AnyCancellable?
    
    @State private var isOpenCamera = false
    @State private var selectedCard: Card?


    private func onViewAppear() {
        viewModel.onViewAppear()
    }
    
    private func onItemCardViewClick(card: Card) {
        selectedCard = card
    }
    
    private func startTimerSearch() {
        
        if let timerCancellable = timerCancellable {
            timerCancellable.cancel()
        }
        
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                viewModel.onSearch(search: searchText, page: page)
                timerCancellable?.cancel()
            }
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                switch viewModel.state {
                case .initial:
                    Text("")
                case .loading:
                    Text("")
                case .fetched:
                    Text("")
                case .fail:
                    Text("")
                }
                
                ZStack(alignment: .bottomTrailing) {
                    VStack(alignment: .center) {
                        List {
                            ForEach(viewModel.cards) { card in
                                ItemCardView(card: card)
                                    .listRowSeparator(.hidden)
                                    .onTapGesture {
                                        onItemCardViewClick(card: card)
                                    }
                            }
                        }
                        .listStyle(.plain)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onAppear() {
                        onViewAppear()
                    }
                    
                    HStack {}
                        .sheet(isPresented: $isOpenCamera) {
                            weScanView
                        }
                    HStack {}
                        .sheet(item: $selectedCard) { selectedCard in
                            DetailView(card: selectedCard)
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Cards")
                        .titleLabelStyle()
                }
            
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("open camera!")
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.app)
                    }
                }
            }

            .searchable(text: $searchText)
            .onChange(of: searchText) { _, newValue in
                if newValue.isEmpty {
                    page = 1
                }
                startTimerSearch()
            }
        }
    }
    
    private var weScanView: some View {
        WeScanView(
            resultAction: { result in
                
                isOpenCamera = false
                
                switch (result) {
                case .success(let imageResult):
                    let imageDetect = imageResult.croppedScan.image
                    
                case .failure(let err):
                    print("WeScanView failure: \(err)")
                }
                
            }, cancelAction: {
                print("cancel action")
                isOpenCamera = false
            })
    }
}

