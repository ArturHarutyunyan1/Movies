//
//  MediaView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 09.04.25.
//

import SwiftUI

struct MediaView: View {
    @EnvironmentObject private var apiManager: ApiManager
    @Namespace private var animation
    var media: Media
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .frame(width: 5, height: 10)
                    .background(.yellow)
                Text("Media")
                    .font(.custom("Poppins-semibold", size: 17))
                Spacer()
            }
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(media.posters.prefix(20), id: \.file_path) {poster in
                        NavigationLink() {
                            ImageView(path: poster.file_path)
                                .navigationTransition(.zoom(sourceID: poster.file_path, in: animation))
                        } label: {
                            VStack {
                                AsyncImage(url: URL(string: "\(apiManager.posterPath)/w342/\(poster.file_path)")) {image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            .frame(width: 144, height: 210)
                            .cornerRadius(15)
                            .matchedTransitionSource(id: poster.file_path, in: animation)
                        }
                    }
                }
            }
        }
    }
}
