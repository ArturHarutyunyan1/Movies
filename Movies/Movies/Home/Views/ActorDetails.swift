//
//  ActorDetails.swift
//  Movies
//
//  Created by Artur Harutyunyan on 01.04.25.
//

import SwiftUI

struct ActorDetailsView: View {
    @EnvironmentObject private var apiManager: ApiManager
    @Namespace private var animation
    var name: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView (.vertical, showsIndicators: false) {
                    if let actor = apiManager.actor?.results {
                        VStack {
                            if let path = actor.first?.profile_path {
                                VStack {
                                    AsyncImage (url: URL(string: apiManager.posterPath + "w500/" + path)) {result in
                                        result
                                            .resizable()
                                            .scaledToFill()
                                            .cornerRadius(15)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            } else {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(15)
                                    .frame(width: geometry.size.width, height: 500)
                                    .background(.gray)
                            }
                        }
                        .frame(width: geometry.size.width)
                        .cornerRadius(15)
                        VStack {
                            if let name = actor.first?.name,
                               let rating = actor.first?.popularity,
                               let role = actor.first?.known_for_department {
                                HStack {
                                    Text("\(name), \(role)")
                                    Image(systemName: "star")
                                        .foregroundStyle(.orange)
                                    Text("\(rating, specifier: "%.1f")")
                                        .foregroundStyle(.orange)
                                }
                                .font(.custom("Poppins-Bold", size: 25))
                            }
                        }
                        VStack {
                            HStack {
                                Text("Known For")
                                    .font(.custom("Poppins-Bold", size: 25))
                                Spacer()
                            }
                            .padding()
                            ScrollView (.horizontal, showsIndicators: false) {
                                if let results = apiManager.actor?.results {
                                    let knownMovies = results.flatMap {$0.known_for}
                                    Card(items: knownMovies) { item in
                                        NavigationLink() {
                                            if item.media_type == "tv" {
                                                ShowDetailsView(id: item.id, type: "tv")
                                                    .navigationTransition(.zoom(sourceID: item.id, in: animation))
                                            } else {
                                                DetailsView(id: item.id, type: "movie")
                                                    .navigationTransition(.zoom(sourceID: item.id, in: animation))
                                            }
                                        } label: {
                                            VStack {
                                                VStack {
                                                    if let path = item.poster_path {
                                                        VStack {
                                                            AsyncImage (url: URL(string: apiManager.posterPath + "w500/" + path)) {result in
                                                                result
                                                                    .resizable()
                                                                    .scaledToFill()
                                                                    .cornerRadius(15)
                                                            } placeholder: {
                                                                ProgressView()
                                                            }
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
                                                HStack {
                                                    if let title = item.title {
                                                        Text("\(title)")
                                                    }
                                                    if let name = item.name {
                                                        Text("\(name)")
                                                    }
                                                    Spacer()
                                                }
                                                .frame(width: 144)
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                            }
                                            .foregroundStyle(.white)
                                            .matchedTransitionSource(id: item.id, in: animation)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            Credit(geometry: geometry)
                        }
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(.customBlue)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                apiManager.actor = nil
                await apiManager.getActor(for: name)
            }
        }
    }
}
