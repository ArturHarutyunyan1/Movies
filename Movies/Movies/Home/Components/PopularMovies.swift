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
    @Namespace private var animation
    var geometry: GeometryProxy
    var body: some View {
        VStack {
            HStack {
                Text("Popular Movies")
                    .font(.custom("Poppins-Bold", size: 25))
                Spacer()
            }
            .padding()
            ScrollView (.horizontal, showsIndicators: false) {
                if let movies = apiManager.popular?.results {
                    Card(items: movies) { movie in
                        NavigationLink() {
                            DetailsView(id: movie.id)
                                .navigationTransition(.zoom(sourceID: movie.id, in: animation))
                        } label: {
                            VStack {
                                AsyncImage(url: URL(string: apiManager.posterPath + "/w500/" + movie.poster_path)) {result in
                                    result
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(15)
                                } placeholder: {
                                    ProgressView()
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
                            .foregroundStyle(.white)
                            .matchedTransitionSource(id: movie.id, in: animation)
                        }
                    }
                }
            }
        }
        .padding()
    }
}
