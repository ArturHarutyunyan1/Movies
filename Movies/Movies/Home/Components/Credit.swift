//
//  Credit.swift
//  Movies
//
//  Created by Artur Harutyunyan on 19.04.25.
//

import SwiftUI

struct Credit: View {
    var geometry: GeometryProxy
    var body: some View {
        VStack {
            Image("tmdb")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            Text("This product uses the TMDB API but is not endorsed or certified by TMDB")
        }
        .frame(width: geometry.size.width * 0.9)
    }
}
