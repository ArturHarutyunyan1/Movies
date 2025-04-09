//
//  Movies.swift
//  Movies
//
//  Created by Artur Harutyunyan on 01.04.25.
//

import SwiftUI

struct Movies: View {
    var geometry: GeometryProxy
    var body: some View {
        VStack {
            ScrollView (.vertical, showsIndicators: false) {
                NowPlayingMovies(geometry: geometry)
                TopRatedView(geometry: geometry)
                PopularMovies(geometry: geometry)
            }
        }
//        .background(.customBlue)
    }
}
