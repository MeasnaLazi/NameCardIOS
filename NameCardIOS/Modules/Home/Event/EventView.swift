//
//  EventView.swift
//  NameCardIOS
//
//  Created by Measna on 15/2/24.
//

import SwiftUI
import Combine

struct EventView : View {
    @State private var timerCancellable: AnyCancellable?
    @State private var count = 0
    
    @State var items:[Int] = []
    @State var isSearch = false
    @State var isOpenConfig = false
    @State var isOpenConnection = false
    
    private func startTimerAddPeople() {
        
        if let timerCancellable = timerCancellable {
            timerCancellable.cancel()
        }
        
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if count >= 5 {
                    timerCancellable?.cancel()
                    count = 0
                    isSearch.toggle()
                } else {
                    withAnimation {
                        items.insert(items.count, at: 0)
                        count += 1
                    }
                }
            }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Toggle(isOn: $isOpenConnection) {
                        Text("Connect with people")
                            .font(.primary(.regular))
                    }
                    .onChange(of: isOpenConnection){ oldVal, newVal in
                        if newVal {
                            isOpenConfig.toggle()
                        } else {
                            items = []
                        }
                    }
                    .padding(.bottom)
                    
                    if  isOpenConnection {
                        listPeopleView
                    }
                    Spacer()
                }
                .padding()
         
                if isSearch {
                    AnimationAirView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Event")
                        .titleLabelStyle()
                }
            }
        }
        .sheet(isPresented: $isOpenConfig, onDismiss: {
            if !isSearch {
                isOpenConnection.toggle()
            }
        }) {
            FilterConfigView() { isReady in
                if isReady {
                    isSearch.toggle()
                    startTimerAddPeople()
                }
                isOpenConfig.toggle()
            }
            .presentationDetents([.fraction(0.5)])
        }
    }
    
    private var listPeopleView: some View {
        let gridItems = Array(
            repeating: GridItem(.adaptive(minimum: 70),
                spacing: 16,
                alignment: .center
            ),
            count: 4
        )
        
        return ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: gridItems, alignment: .center, spacing: 16) {
                    ForEach(items, id: \.self) { item in
                        Image("imgNaruto")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .clipShape(.circle)
                            .aspectRatio(contentMode: .fill)
                            .transition(.scale)
                            
                    }
                }
            }
        .refreshable {
            print("refresh work fine for async/await but not sure for other concurrent")
        }
    }
}
