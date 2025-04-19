//
//  NotFound.swift
//  Movies
//
//  Created by Artur Harutyunyan on 19.04.25.
//

import SwiftUI

struct NotFound: View {
    var geometry: GeometryProxy
    var body: some View {
        VStack {
            Image("notfound")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
            Text("Nothing found")
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
    }
}

