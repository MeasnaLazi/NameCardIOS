//
//  ConfigView.swift
//  NameCardIOS
//
//  Created by Measna on 20/2/24.
//

import SwiftUI

struct FilterConfigView: View {
    
    @State private var searchText: String = ""
    @State private var allPosition: [String] = ["UI Design", "Sale", "Marketing", "Software Developer", "IT Manager", "CEO", "COO", "CFO"]
    @State private var filteredPositions: [String] = []
    @State private var positions: [String] = ["CEO", "COO", "CFO", "Software Developer", "IT Manager"]
    
    var action: ((Bool) -> Void)
    
    
    private func onReadyClick() {
        action(true)
    }
    
    private func deleteTag(_ tag: String) {
      positions.removeAll { $0 == tag }
    }
    
    private func filterSuggestions(for searchText: String) {
        // should return only 2 elements max
        filteredPositions = allPosition.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
        
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Select people you want to find")
                        .font(.primary(.medium, size: 14))
                        .padding(.leading, 8)
                 
                SearchBarView(text: $searchText)
                    .onChange(of: searchText) { _, newValue in
                        filterSuggestions(for: newValue)
                    }
                    .border(.white, width: 1)
                
              
                List(filteredPositions, id: \.self) { position in
                    Text(position)
                        .font(.primary(.regular))
                        .onTapGesture {
                            if positions.contains(where: { $0 != position }) {
                                positions.append(position)
                            }
                            searchText = ""
                            hideKeyboard()
                        }
                }
                .listStyle(PlainListStyle())
                .background(.white)
                
                FlowLayout(mode: .scrollable,
                               items: positions,
                               itemSpacing: 4) { tag in
                    
                    TagView(tag: tag, onDelete: { deleteTag(tag) })
                }
                .padding()
                
                Button("OPEN CONNECTION", action: onReadyClick)
                    .buttonStyle(FullWidthButton())
                    .accessibilityIdentifier("openConnectionButton")
                    .padding(.horizontal, 10)
            }
            .padding()
            .padding(.top, 20)
            
            Button(action: {
                action(false)
               }) {
                   Image(systemName: "xmark")
                       .font(.system(size: 12))
               }
               .buttonStyle(OvalCloseButton())
               .padding(.top, 10)
               .padding(.trailing, 10)
        }
    }
}
