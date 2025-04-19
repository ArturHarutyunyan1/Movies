//
//  SearchResults.swift
//  Movies
//
//  Created by Artur Harutyunyan on 06.04.25.
//

import SwiftUI

struct SearchResultsView: View {
    @EnvironmentObject private var apiManager: ApiManager
    var body: some View {
        GeometryReader {geometry in
            ScrollView (.vertical, showsIndicators: false) {
                if let search = apiManager.search {
                    if search.results.count == 0 {
                        NotFound(geometry: geometry)
                    } else {
                        VStack {
                            if search.results.contains(where: {$0.media_type == "movie"}) {
                                MoviesView(geometry: geometry)
                            }
                            if search.results.contains(where: {$0.media_type == "tv"}) {
                                ShowsView(geometry: geometry)
                            }
                            if search.results.contains(where: {$0.media_type == "person"}) {
                                People(geometry: geometry)
                            }
                            Credit(geometry: geometry)
                        }
                    }
                }
            }
        }
        .background(.customBlue)
    }
}
