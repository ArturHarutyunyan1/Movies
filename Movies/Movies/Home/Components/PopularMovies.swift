//
//  PopularMovies.swift
//  Movies
//
//  Created by Artur Harutyunyan on 31.03.25.
//

import SwiftUI

struct PopularMovies: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @EnvironmentObject private var apiManager: ApiManager
    var geometry: GeometryProxy
    var body: some View {
        VStack {
            ScrollView (.horizontal, showsIndicators: false) {
                if let movies = apiManager.popular?.results {
                    HStack {
                        ForEach(movies, id: \.id) {movie in
                            VStack {
                                AsyncImage(url: URL(string: apiManager.posterPath + "/w500/" + movie.poster_path)) {result in
                                    result.image?
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(15)
                                }
                                .frame(width: 144, height: 210)
                                HStack{
                                    Text("\(movie.title)")
                                    Spacer()
                                }
                                .frame(width: 144)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}
