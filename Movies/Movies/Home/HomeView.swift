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
                content(using: geometry)
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            BottomBar(geometry: geometry, chosenView: $chosenView)
                        }
                    }
                    .background(.customBlue)
            }
        }
        .task {
            await apiManager.getPopularMovies()
        }
    }
    
    @ViewBuilder
    private func content(using geometry: GeometryProxy) -> some View {
        if chosenView == .search {
            SearchView(geometry: geometry)
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                currentContent(using: geometry)
            }
        }
    }

    @ViewBuilder
    private func currentContent(using geometry: GeometryProxy) -> some View {
        switch chosenView {
        case .movies:
            Movies(geometry: geometry)
        case .shows:
            Shows(geometry: geometry)
        case .saved:
            Saved(geometry: geometry)
        default:
            EmptyView()
        }
    }
}
