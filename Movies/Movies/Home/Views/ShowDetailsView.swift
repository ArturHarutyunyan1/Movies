//
//  ShowDetailsView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 06.04.25.
//

import SwiftUI

struct ShowDetailsView: View {
    @EnvironmentObject private var apiManager: ApiManager
    var id: Int
    var body: some View {
        GeometryReader {geometry in
            ScrollView (.vertical, showsIndicators: false) {
                if let details = apiManager.showDetails {
                    VStack {
                        if let path = details.backdrop_path {
                            AsyncImage(url: URL(string: apiManager.posterPath + "/w1280/" + path)) {result in
                                result
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                    .frame(height: 300)
                    HStack {
                        VStack {
                            if let path = details.poster_path {
                                AsyncImage(url: URL(string: apiManager.posterPath + "/w500/" + path)) {result in
                                    result
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(15)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .frame(width: 144, height: 210)
                        VStack {
                            HStack {
                                Text("\(details.original_name)")
                                    .font(.custom("Poppins-Bold", size: 25))
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "star")
                                Text("\(details.vote_average, specifier: "%.1f")")
                                Spacer()
                            }
                            .foregroundStyle(.orange)
                            HStack {
                                Image(systemName: "clock")
                                Text("\(details.episode_run_time[0]) Minutes")
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "movieclapper")
                                VStack(alignment: .leading) {
                                    let columns = [GridItem(.adaptive(minimum: 80), spacing: 8)]
                                    LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                                        ForEach(details.genres, id: \.id) { genre in
                                            Text(genre.name)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(8)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .background(.customBlue)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                apiManager.showDetails = nil
//                apiManager.reviews = nil
//                apiManager.cast = nil
                await apiManager.getDetails(for: id, with: "tv")
//                await apiManager.getReviews(for: id)
//                await apiManager.getCast(for: id)
            }
        }
    }
}
