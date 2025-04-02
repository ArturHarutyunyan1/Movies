//
//  SearchView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 02.04.25.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var apiManager: ApiManager
    @Binding var searchText: String
    var geometry: GeometryProxy
    var body: some View {
        VStack {
            ScrollView (.vertical, showsIndicators: false) {
                VStack {
                    if let searchResults = apiManager.search {
                        VStack {
                            if searchResults.results.filter({$0.media_type == "movie"}).count > 0 {
                                Text("Movie")
                            }
                            if searchResults.results.filter({$0.media_type == "tv"}).count > 0 {
                                Text("Show")
                            }
                            if searchResults.results.filter({$0.media_type == "person"}).count > 0 {
                                People(geometry: geometry)
                            }
                        }
                    }
                }
            }
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
        .background(.customBlue)
        .onChange(of: searchText) {
            Task {
                if searchText.count > 3 {
                    await apiManager.getSearchResults(for: searchText)
                }
            }
        }
    }
}
