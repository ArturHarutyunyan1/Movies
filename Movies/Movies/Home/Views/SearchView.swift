//
//  SearchView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 02.04.25.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var apiManager: ApiManager
    @State private var searchText: String = ""
    @State private var isLoading: Bool = false
    @FocusState private var isSearchFocused: Bool
    var geometry: GeometryProxy

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                if isLoading {
                    ProgressView("Searching...")
                }
                if let searchResults = apiManager.search {
                    VStack {
                        if searchResults.results.contains(where: { $0.media_type == "movie" }) {
                            Text("Movie")
                        }
                        if searchResults.results.contains(where: { $0.media_type == "tv" }) {
                            Text("Show")
                        }
                        if searchResults.results.contains(where: { $0.media_type == "person" }) {
                            People(geometry: geometry)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .searchable(text: $searchText, prompt: "Search for a movie, show or a person") // Moved here
        .frame(width: geometry.size.width, height: geometry.size.height)
        .background(.customBlue)
        .onChange(of: searchText) {
            Task {
                if searchText.count > 3 {
                    isLoading = true
                    await apiManager.getSearchResults(for: searchText)
                    isLoading = false
                } else {
                    apiManager.search = nil
                }
            }
        }
    }
}
