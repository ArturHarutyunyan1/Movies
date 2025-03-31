//
//  Cast.swift
//  Movies
//
//  Created by Artur Harutyunyan on 01.04.25.
//

import SwiftUI

import SwiftUI

struct Cast: View {
    @EnvironmentObject private var apiManager: ApiManager
    var cast: CastResults

    var body: some View {
        let columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]
        
        LazyVGrid(columns: columns, alignment: .leading) {
            ForEach(cast.cast.filter { $0.known_for_department == "Acting" && $0.profile_path != nil }, id: \.id) { member in
                VStack {
                    if let image = member.profile_path {
                        AsyncImage(url: URL(string: apiManager.posterPath + "w185" + image)) { result in
                            result.image?
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                        }
                        .frame(width: 100, height: 100)
                    }
                    VStack {
                        Text("\(member.name)")
                        Text("\(member.character)")
                            .foregroundStyle(.gray)
                    }
                    .lineLimit(1)
                }
            }
        }
        .padding()
    }
}
