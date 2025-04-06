//
//  Shows.swift
//  Movies
//
//  Created by Artur Harutyunyan on 01.04.25.
//

import SwiftUI

struct Shows: View {
    var body: some View {
        GeometryReader {geometry in
            VStack {
                ScrollView (.vertical, showsIndicators: false) {
                    Text("Shows view")
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .background(.customBlue)
    }
}
