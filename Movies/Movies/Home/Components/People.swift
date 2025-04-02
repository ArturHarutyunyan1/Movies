//
//  People.swift
//  Movies
//
//  Created by Artur Harutyunyan on 02.04.25.
//

import SwiftUI

struct People: View {
    @EnvironmentObject private var apiManager: ApiManager
    @Namespace private var animation
    var geometry: GeometryProxy
    var body: some View {
        VStack {
            HStack {
                Text("People")
                    .font(.custom("Poppins-Bold", size: 25))
                Spacer()
            }
            .padding()
            ScrollView (.horizontal, showsIndicators: false) {
                if let people = apiManager.search?.results.filter({$0.media_type == "person" && $0.known_for_department == "Acting"}) {
                    Card(items: people) { person in
                        NavigationLink() {
                            ActorDetailsView(name: person.name ?? "")
                                .navigationTransition(.zoom(sourceID: person.id, in: animation))
                        } label: {
                            VStack {
                                VStack {
                                    if let path = person.profile_path {
                                        AsyncImage(url: URL(string: apiManager.posterPath + "w185/" + path)) {result in
                                            result
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(15)
                                        } placeholder: {
                                            ProgressView()
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
                                HStack{
                                    if let name = person.name {
                                        Text("\(name)")
                                    }
                                    Spacer()
                                }
                                .frame(width: 144)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            }
                            .foregroundStyle(.white)
                            .matchedTransitionSource(id: person.id, in: animation)
                        }
                    }
                }
            }
        }
        .padding()
    }
}
