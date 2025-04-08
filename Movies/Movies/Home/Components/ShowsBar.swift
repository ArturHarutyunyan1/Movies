//
//  ShowsView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 02.04.25.
//

import SwiftUI

struct ShowsView: View {
    @EnvironmentObject private var apiManager: ApiManager
    @Namespace private var animation
    var geometry: GeometryProxy
    var body: some View {
        VStack {
            HStack {
                Text("Shows")
                    .font(.custom("Poppins-Bold", size: 25))
                Spacer()
            }
            .padding()
            ScrollView (.horizontal, showsIndicators: false) {
                if let movies = apiManager.search?.results.filter({$0.media_type == "tv"}) {
                    Card(items: movies) { movie in
                        NavigationLink() {
                            ShowDetailsView(id: movie.id, type: "tv")
                                .navigationTransition(.zoom(sourceID: movie.id, in: animation))
                        } label: {
                            VStack {
                                VStack {
                                    if let path = movie.poster_path {
                                        AsyncImage(url: URL(string: apiManager.posterPath + "w185/" + path)) {result in
                                            result
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(15)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    } else {
                                        Image(systemName: "film")
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(15)
                                            .frame(width: 144, height: 210)
                                            .background(.gray)
                                    }
                                }
                                .frame(width: 144, height: 210)
                                .cornerRadius(15)
                                HStack{
                                    if let name = movie.title {
                                        Text("\(name)")
                                    }
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
