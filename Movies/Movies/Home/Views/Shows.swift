//
//  Shows.swift
//  Movies
//
//  Created by Artur Harutyunyan on 01.04.25.
//

import SwiftUI

struct Shows: View {
    var geometry: GeometryProxy
    var body: some View {
        VStack {
            ScrollView (.vertical, showsIndicators: false) {
                AiringTodayView(geometry: geometry)
            }
        }
    }
}
