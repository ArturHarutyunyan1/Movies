//
//  Cast.swift
//  Movies
//
//  Created by Artur Harutyunyan on 01.04.25.
//

import SwiftUI

struct Cast: View {
    @EnvironmentObject private var apiManager: ApiManager
    @Namespace private var animation
    var cast: CastResults
    var body: some View {
        VStack {
            HStack {
                Text("Cast")
                    .font(.custom("Poppins-Bold", size: 25))
                Spacer()
            }
            .padding()
            ScrollView (.horizontal, showsIndicators: false) {
                if let castMembers = apiManager.cast?.cast {
                    Card(items: castMembers) {person in
                        NavigationLink() {
                            ActorDetailsView(name: person.name)
                                .navigationTransition(.zoom(sourceID: person.name, in: animation))
                        } label: {
                            VStack {
                                VStack {
                                    if let path = person.profile_path {
                                        AsyncImage(url: URL(string: apiManager.posterPath + "w185/" + path)) {result in
                                            result.image?
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(15)
                                        }
                                    } else {
                                        Image(systemName: "person")
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(15)
                                            .frame(width: 144, height: 210)
                                            .background(.gray)
                                    }
                                }
                                .frame(width: 144, height: 210)
                                .cornerRadius(15)
                                VStack {
                                    HStack {
                                        Text(person.name)
                                        Spacer()
                                    }
                                    HStack {
                                        Text(person.known_for_department)
                                        Spacer()
                                    }
                                }
                                .frame(width: 144)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            }
                            .foregroundStyle(.white)
                            .matchedTransitionSource(id: person.name, in: animation)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
