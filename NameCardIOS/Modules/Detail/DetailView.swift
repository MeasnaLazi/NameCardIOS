//
//  DetailView.swift
//  NameCardIOS
//
//  Created by Measna on 27/11/23.
//

import SwiftUI

struct DetailView : View {
    
    var card: Card
    
    @State
    private var opacity = 0.0
    
    var body: some View {
        VStack(spacing: 0) {
            imageView
            
            ZStack(alignment: .top) {
                informationView
                VStack(spacing: 0) {
                    buttonContainerView
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(.border2)
                }
                .opacity(opacity)
            }
        }
        .background(Color.white.ignoresSafeArea())
     
    }
    
    private var imageView : some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: card.image.toFullPath())) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    private var informationView : some View {
        List {
            buttonContainerView
                .onDisappear() {
                    withAnimation {
                        opacity = 1
                    }
                }
                .onAppear() {
                    withAnimation {
                        opacity = 0
                    }
                }
                .padding(.top, -12)
                .padding(.bottom, -12)
            
            Section {
                ItemDetailView(label: "Position", text: card.position, icon: "circle.circle")
            }
            Section {
                ItemDetailView(label: "First Name", text: card.firstname, icon: "person.circle")
                
                if let lastname = card.lastname {
                    ItemDetailView(label: "Last Name", text: lastname, icon: "person.circle")
                }
            }
            
            Section {
                ItemDetailView(label: "Phone", text: card.phone, icon: "phone.circle")
           
                ItemDetailView(label: "Email", text: card.email, icon: "envelope.circle")
                
                if let website = card.website {
                    ItemDetailView(label: "Website", text: website, icon: "link.circle")
                }
            }
                
            if let address = card.address {
                Section {
                    ItemDetailView(label: "Address", text: address, icon: "location.circle")
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var buttonContainerView: some View {
        HStack {
            actionView(icon: "phone", text: "Call", actionOpen: .phone)
            Spacer()
            actionView(icon: "envelope", text: "Mail", actionOpen: .email)
            Spacer()
            actionView(icon: "location", text: "Location", actionOpen: .map)
        }
        .padding(.top, 12)
        .padding(.bottom, 12)
        .background(Color.backgroundTable)
        .listRowInsets(EdgeInsets())
        
    }
    
    @ViewBuilder
    private func actionView(icon: String, text: String, actionOpen: DetailView.ActionOpen) -> some View {
        
        VStack {
            Image(systemName: icon)
                .foregroundStyle(.white)
            Text(text)
                .font(.primary(.regular, size: 12))
                .foregroundStyle(.white)
                .padding(.top, 1)
        }
        .padding(.top, 6)
        .padding(.bottom, 6)
        .frame(maxWidth: .infinity)
        .background(Color.app)
        .cornerRadius(5)
        .onTapGesture {
            actionOpen.open(text: text)
        }
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
