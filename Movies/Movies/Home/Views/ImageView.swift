//
//  ImageView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 09.04.25.
//

import SwiftUI

struct ImageView: View {
    @EnvironmentObject private var apiManager: ApiManager
    var path: String
    var body: some View {
        GeometryReader {geometry in
            VStack {
                AsyncImage(url: URL(string: "\(apiManager.posterPath)/w1280/\(path)")) {image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
            .frame(width: geometry.size.width)
        }
        .background(.customBlue)
        .navigationBarBackButtonHidden()
    }
}
