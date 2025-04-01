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
            VStack(spacing: 16) {
                if let actor = apiManager.actor, let actorDetail = actor.results.first {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            // Actor Image
                            if let profilePath = actorDetail.profile_path {
                                AsyncImage(url: URL(string: apiManager.posterPath + "/w1280" + profilePath)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 300)
                                        .clipped()
                                        .cornerRadius(15)
                                        .shadow(radius: 5)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            
                            // Actor Info
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("\(actorDetail.name), Actor")
                                        .font(.title2.bold())
                                    Spacer()
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.orange)
                                    Text("\(actorDetail.popularity, specifier: "%.1f")")
                                        .foregroundColor(.orange)
                                        .font(.subheadline)
                                }
                                
                                // Known For Section
                                Text("Known for")
                                    .font(.title3.bold())
                                    .padding(.vertical, 4)
                                
                                // Works Grid
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 8)], spacing: 16) {
                                    ForEach(actor.results, id: \.id) { result in
                                        ForEach(result.known_for, id: \.id) { work in
                                            NavigationLink() {
                                                DetailsView(id: work.id)
                                                    .navigationTransition(.zoom(sourceID: work.id, in: animation))
                                            } label: {
                                                VStack(spacing: 8) {
                                                    if let path = work.poster_path {
                                                        AsyncImage(url: URL(string: apiManager.posterPath + "/w500/" + path)) { image in
                                                            image
                                                                .resizable()
                                                                .scaledToFill()
                                                                .frame(width: 144, height: 210)
                                                                .clipped()
                                                                .cornerRadius(10)
                                                        } placeholder: {
                                                            ProgressView()
                                                        }
                                                    }
                                                    Text(work.title ?? work.name ?? "")
                                                        .font(.caption)
                                                        .multilineTextAlignment(.center)
                                                }
                                                .matchedTransitionSource(id: work.id, in: animation)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }
                } else {
                    Text("Nothing found")
                        .foregroundColor(.white)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color("customBlue"))
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
