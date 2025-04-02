//
//  HomeView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI

enum Views {
    case movies
    case shows
    case saved
}

struct HomeView: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @EnvironmentObject private var apiManager: ApiManager
    @State private var chosenView: Views = .movies
    var body: some View {
        GeometryReader {geometry in
            NavigationStack {
                ScrollView (.vertical, showsIndicators: false) {
                    switch chosenView {
                    case .movies:
                        Movies(geometry: geometry)
                    case .shows:
                        Shows(geometry: geometry)
                    case .saved:
                        Saved(geometry: geometry)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Spacer()
                            VStack {
                                Image(systemName: "movieclapper")
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
                                Image(systemName: "tv")
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
                                Image(systemName: "bookmark")
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
                }
                .background(.customBlue)
            }
        }
        .onAppear() {
            Task {
                await apiManager.getPopularMovies()
            }
        }
    }
}

