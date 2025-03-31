//
//  DetailsView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 31.03.25.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject private var apiManager: ApiManager
    var id: Int
    var body: some View {
        GeometryReader {geometry in
            ScrollView (.vertical, showsIndicators: false) {
                if let details = apiManager.details {
                    VStack {
                        AsyncImage(url: URL(string: apiManager.posterPath + "/w1280/" + details.backdrop_path)) {result in
                            result.image?
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .frame(height: 300)
                    HStack {
                        VStack {
                            AsyncImage(url: URL(string: apiManager.posterPath + "/w500/" + details.poster_path)) {result in
                                result.image?
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(15)
                            }
                        }
                        .frame(width: 144, height: 210)
                        VStack {
                            HStack {
                                Text("\(details.original_title)")
                                    .font(.custom("Poppins-Bold", size: 25))
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "calendar")
                                if let releaseDate = details.release_date.split(separator: "-").first {
                                    Text("\(releaseDate)")
                                }
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
                                Text("\(details.runtime) Minutes")
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
                    if let reviews = apiManager.reviews {
                        TabViewModel(details: details, reviews: reviews)
                    }
                    Spacer()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .background(.customBlue)
        .navigationTitle("\(apiManager.details?.original_title ?? "")")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                apiManager.details = nil
                apiManager.reviews = nil
                await apiManager.getDetails(for: id)
                await apiManager.getReviews(for: id)
            }
        }
    }
}

