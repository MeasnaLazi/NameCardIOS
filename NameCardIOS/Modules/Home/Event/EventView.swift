//
//  EventView.swift
//  NameCardIOS
//
//  Created by Measna on 15/2/24.
//

import SwiftUI

struct EventView : View {
    private static let sqaulSize: CGFloat = 70
    private static let spacingBtwCols: CGFloat = 16
    private static let spacingBtwRows: CGFloat = 16
    private static let totalColumns: Int = 4
    
    let gridItems = Array(
        repeating: GridItem(
            .adaptive(minimum: Self.sqaulSize),
            spacing: spacingBtwCols,
            alignment: .center
        ),
        count: totalColumns
    )
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    @State var items:[Int] = []
    @State var isSearch = false
    @State var isOpenConfig = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
//                    HStack {
//                        Toggle(isOn: $isSearch) {
//                            Text("Allow others to find you")
//                                .font(.primary(.regular))
//                        }
//                    }
                    
                    HStack {
                        Toggle(isOn: $isSearch) {
                            Text("Connect with people")
                                .font(.primary(.regular))
                        }
                    }
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridItems, alignment: .center, spacing: Self.spacingBtwRows) {
                                    ForEach(items, id: \.self) { item in
                                        Image("imgNaruto")
                                            .resizable()
                                            .frame(width: Self.sqaulSize, height: Self.sqaulSize)
                                            .clipShape(.circle)
                                            .aspectRatio(contentMode: .fill)
                                            .transition(.scale)
                                            
                                    }
                                }
                            }
                }
                .padding()
                
                if isSearch {
                    AnimationView()
                }
                
                HStack {}
                    .sheet(isPresented: $isOpenConfig) {
                        ConfigView()
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Event")
                        .titleLabelStyle()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.app)
                        .onTapGesture {
                            self.isOpenConfig.toggle()
                        }
                }
            }
        }
        .onReceive(timer) { time in
            withAnimation {
//                items.append(items.count)
            }
        }
        

    }
}

struct ConfigView: View {
    var body: some View {
        Text("Configure!")
    }
}

struct AnimationView: View {
    
    private static let sqaulSize: CGFloat = 60
    private static let airCircleSize: CGFloat = 130
    
    @State var isAir1 = false
    @State var isAir2 = false
    @State var isAnimate = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.white.opacity(0.6))
                .frame(width: Self.airCircleSize, height: Self.airCircleSize)
                .scaleEffect(isAir1 ? 3.3 : 0)
                .opacity(isAir1 ? 0 : 1)
            
            Circle()
                .stroke(.white.opacity(0.5))
                .frame(width: Self.airCircleSize, height: Self.airCircleSize)
                .scaleEffect(isAir2 ? 3.3 : 0)
                .opacity(isAir2 ? 0 : 1)
            
            Circle()
                .fill(.white)
                .frame(width: Self.sqaulSize, height: Self.sqaulSize)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
                .overlay {
                    Image(systemName: "location")
                        .font(.title)
                        .foregroundColor(.app)
                }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.5))
        .onAppear() {
            animated()
        }
    }
    
    private func animated() {
        withAnimation(Animation.linear(duration: 1.7).repeatForever(autoreverses: false)) {
            isAnimate.toggle()
        }
        withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)) {
            isAir1.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)) {
                isAir2.toggle()
            }
        }
    }
}
