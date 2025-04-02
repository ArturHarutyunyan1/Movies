//
//  BottomBar.swift
//  Movies
//
//  Created by Artur Harutyunyan on 02.04.25.
//

import SwiftUI

struct BottomBar: View {
    var geometry: GeometryProxy
    @Binding var chosenView: Views
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: chosenView == .movies ? "movieclapper.fill" : "movieclapper")
                Text("Movies")
            }
            .foregroundStyle(chosenView == .movies ? .foregroundBlue : .white)
            .onTapGesture {
                withAnimation {
                    chosenView = .movies
                }
            }
            Spacer()
            VStack {
                Image(systemName: chosenView == .shows ? "tv.fill" : "tv")
                Text("Shows")
            }
            .foregroundStyle(chosenView == .shows ? .foregroundBlue : .white)
            .onTapGesture {
                withAnimation {
                    chosenView = .shows
                }
            }
            Spacer()
            VStack {
                Image(systemName: chosenView == .saved ? "bookmark.fill" : "bookmark")
                Text("Bookmarks")
            }
            .foregroundStyle(chosenView == .saved ? .foregroundBlue : .white)
            .onTapGesture {
                withAnimation {
                    chosenView = .saved
                }
            }
            Spacer()
        }
        .padding()
        .frame(width: geometry.size.width)
    }
}

