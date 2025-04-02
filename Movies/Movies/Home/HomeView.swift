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
    @State private var searchText: String = ""
    @FocusState private var isSearchFocused: Bool
    var body: some View {
        GeometryReader {geometry in
            NavigationStack {
                ScrollView (.vertical, showsIndicators: false) {
                    if isSearchFocused {
                        SearchView(searchText: $searchText, geometry: geometry)
                    } else {
                        switch chosenView {
                        case .movies:
                            Movies(geometry: geometry)
                        case .shows:
                            Shows(geometry: geometry)
                        case .saved:
                            Saved(geometry: geometry)
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search for a movie, show or a person")
                .searchFocused($isSearchFocused)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        BottomBar(geometry: geometry, chosenView: $chosenView)
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

