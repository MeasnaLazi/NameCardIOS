//
//  DetailView.swift
//  NameCardIOS
//
//  Created by Measna on 27/11/23.
//

import SwiftUI

struct DetailView : View {
    
    var card: Card
    var animation: Namespace.ID
    
    @Binding var showDetailCard: Bool
    @State var isShowInfo:Bool = false
    @State var showInfoOpacity = 1.0
    
    
    private func onViewAppear() {
        withAnimation(.easeOut.delay(0.1)) {
            isShowInfo = true
        }
    }
    
    private func onCardViewClick() {
        withAnimation(.easeInOut) {
            isShowInfo = false
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
                    VStack(spacing: 14) {
                        ItemDetailView(label: "First Name", text: card.firstname, icon: "person.circle", actionOpen: .none)
                        Divider()
                        
                        if let lastname = card.lastname {
                            ItemDetailView(label: "Last Name", text: lastname, icon: "person.circle", actionOpen: .none)
                            Divider()
                        }
                        ItemDetailView(label: "Position", text: card.position, icon: "checkmark.circle", actionOpen: .none)
                        Divider()
                        ItemDetailView(label: "Phone", text: card.phone, icon: "phone.circle", actionOpen: .phone)
                        Divider()
                        ItemDetailView(label: "Email", text: card.email, icon: "envelope.circle", actionOpen: .email)
                        Divider()
                        
                        if let address = card.address {
                            ItemDetailView(label: "Address", text: address, icon: "location.circle", actionOpen: .map)
                            Divider()
                        }
                        
                        if let website = card.website {
                            ItemDetailView(label: "Website", text: website, icon: "link.circle", actionOpen: .website)
                            Divider()
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.white.clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous)))
                .offset(y: isShowInfo ? 0 : height)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
            .padding([.horizontal, .top])
            .zIndex(-10)
            .opacity(showInfoOpacity)
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
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .shadow, radius: 5)
                }
        }
        .modifier(SwipeToDismissModifier(
            onChange: { height in
                let h = height - 50
                if (h < 0 ) {
                    showInfoOpacity = 1
                } else {
                    showInfoOpacity = 10 / h
                }
            },
            onDismiss: {
                withAnimation(.easeInOut) {
                    showDetailCard = false
                    isShowInfo = false
                }
            }))
    }
}

struct SwipeToDismissModifier: ViewModifier {
    var onChange: (_ height: Double) -> Void
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .offset(y: offset.height)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        onChange(gesture.translation.height)
                        if gesture.translation.width < 50 {
                            offset = gesture.translation
                        }
                    }
                    .onEnded { _ in
                        if abs(offset.height) > 100 {
                            onDismiss()
                        } else {
                            offset = .zero
                            onChange(49)
                        }
                    }
            )
    }
}

extension DetailView {
    enum ActionOpen {
        case phone
        case email
        case map
        case website
        case none
        
        func open(text: String) {
            var url: URL?
            switch self {
            case .phone:
                url = URL(string: "tel://\(text)")
            case .email:
                url = URL(string: "mailto:\(text)")
            case .map:
                url = URL(string: "http://maps.apple.com/?address=\(text)")
            case .website:
                url = URL(string: text)
            default:
                url = nil
            }
            
            guard let url = url else {
                return
            }
            guard UIApplication.shared.canOpenURL(url) else {
                print("can not open : \(url)")
                return
            }
            
            UIApplication.shared.open(url, options: [:])
            
        }
    }
}
