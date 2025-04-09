//
//  HomeView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @EnvironmentObject private var apiManager: ApiManager
    @State private var chosenView: Views = .movies
    @State private var searchText: String = ""
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack(spacing: 0) {
                    SearchView(geometry: geometry)
                    TabView(selection: $chosenView) {
                        Movies(geometry: geometry)
                            .tag(Views.movies)
                        Shows()
                            .tag(Views.shows)
                        Saved(geometry: geometry)
                            .tag(Views.saved)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .animation(.easeInOut(duration: 0.3), value: chosenView)
                }
                .background(.customBlue)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        BottomBar(geometry: geometry, chosenView: $chosenView)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .background(.customBlue)
        .task {
            await apiManager.getPopularMovies()
            await apiManager.getNowPlaying()
            await apiManager.getTopRatedMovies()
        }
    }
}
