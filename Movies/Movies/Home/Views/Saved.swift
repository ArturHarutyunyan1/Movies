//
//  Saved.swift
//  Movies
//
//  Created by Artur Harutyunyan on 01.04.25.
//

import SwiftUI

struct Saved: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @EnvironmentObject private var apiManager: ApiManager
    @EnvironmentObject private var databaseManager: DatabaseManager
    @Namespace private var animation
    var geometry: GeometryProxy
    let columns = [
        GridItem(.fixed(120)),
        GridItem(.fixed(120)),
        GridItem(.fixed(120))
    ]
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            if databaseManager.userBookmarks.count > 0, let email = authenticationManager.user?.email {
                LazyVGrid (columns: columns) {
                    ForEach(databaseManager.userBookmarks.filter {$0.email == email}, id: \.id) {bookmark in
                        NavigationLink() {
                            if bookmark.mediaType == "movie" {
                                DetailsView(id: bookmark.id, type: bookmark.mediaType)
                                    .navigationTransition(.zoom(sourceID: bookmark.id, in: animation))
                            } else {
                                ShowDetailsView(id: bookmark.id, type: bookmark.mediaType)
                                    .navigationTransition(.zoom(sourceID: bookmark.id, in: animation))
                            }
                        } label: {
                            VStack {
                                AsyncImage(url: URL(string: apiManager.posterPath + "/w500/" + bookmark.path)) {result in
                                    result
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(15)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 120, height: 210)
                                HStack{
                                    Text("\(bookmark.title)")
                                    Spacer()
                                }
                                .frame(width: 120)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            }
                            .foregroundStyle(.white)
                            .matchedTransitionSource(id: bookmark.id, in: animation)
                        }
                    }
                }
            } else {
                Text("Empty")
            }
        }
        .frame(width: geometry.size.width)
    }
}
