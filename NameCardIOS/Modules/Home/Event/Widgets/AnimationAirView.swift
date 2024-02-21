//
//  AnimationAirView.swift
//  NameCardIOS
//
//  Created by Measna on 20/2/24.
//

import SwiftUI

struct AnimationAirView: View {
    
    private static let sqaulSize: CGFloat = 60
    private static let airCircleSize: CGFloat = 130
    
    @State var isAir1 = false
    @State var isAir2 = false
    @State var isAnimate = false
    
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
}

