//
//  BottomBar.swift
//  Movies
//
//  Created by Artur Harutyunyan on 02.04.25.
//

import SwiftUI

enum Views {
    case movies
    case shows
    case saved
    case search
}

struct BottomBar: View {
    var geometry: GeometryProxy
    @Binding var chosenView: Views
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .foregroundStyle(chosenView == .search ? .foregroundBlue : .white)
                .onTapGesture {
                    withAnimation {
                        chosenView = .search
                    }
                }
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
            .frame(width: geometry.size.width)
        }
        .padding()
    }
}

