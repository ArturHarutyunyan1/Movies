//
//  HomeView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @EnvironmentObject private var apiManager: ApiManager
    var body: some View {
        GeometryReader {geometry in
            NavigationStack {
                ScrollView (.vertical, showsIndicators: false) {
                    PopularMovies(geometry: geometry)
                }
                .background(.customBlue)
            }
            .background(.customBlue)
        }
        .onAppear() {
            Task {
                await apiManager.getPopularMovies()
            }
        }
    }
}

