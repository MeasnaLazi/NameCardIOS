//
//  DetailView.swift
//  NameCardIOS
//
//  Created by Measna on 27/11/23.
//

import SwiftUI

struct DetailView : View {
    
    var card: Card
    @Binding var showDetailCard: Bool
    var animation: Namespace.ID
    @State var isShowExpense:Bool = false
    
    private func onViewAppear() {
        withAnimation(.easeOut.delay(0.1)) {
            isShowExpense = true
        }
    }
    
    private func onCardViewClick() {
        withAnimation(.easeInOut) {
            isShowExpense = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.35)) {
                showDetailCard = false
            }
        }
    }
    
    var body: some View {
        VStack {
            cardView
                .matchedGeometryEffect(id: card.id, in: animation)
                .frame(height: 200)
                .zIndex(10)
                .onTapGesture {
                    onCardViewClick()
                }
                
            GeometryReader { proxy in
                let height = proxy.size.height + 50
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        // TODO
                        ForEach(0..<20) {_ in 
                            ItemDetailView()
                            Divider()
                        }
                       
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.white.clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).ignoresSafeArea())
                .offset(y: isShowExpense ? 0 : height)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
            .padding([.horizontal, .top])
            .zIndex(-10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.bgDefault.ignoresSafeArea())
        .onAppear() {
            onViewAppear()
        }
    }
    
    private var cardView : some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: card.image.toFullPath())) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: .shadow, radius: 5)
                } placeholder: {
                    ProgressView()
                }
        }
        .modifier(SwipeToDismissModifier(onDismiss: {
            withAnimation(.easeInOut) {
                showDetailCard = false
                isShowExpense = false
            }
        }))
    }
}

struct SwipeToDismissModifier: ViewModifier {
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .offset(y: offset.height)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 50 {
                            offset = gesture.translation
                        }
                    }
                    .onEnded { _ in
                        if abs(offset.height) > 100 {
                            onDismiss()
                        } else {
                            offset = .zero
                        }
                    }
            )
    }
}
