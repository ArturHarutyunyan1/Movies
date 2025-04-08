//
//  TabView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 31.03.25.
//

import SwiftUI

enum Tabs {
    case overview
    case reviews
    case episodes
    case cast
}

struct TabViewModel: View {
    var details: Details?
    var showDetails: ShowDetails?
    var reviews: Reviews
    var cast: CastResults
    var type: String
    var geometry: GeometryProxy
    @State private var chosenTab: Tabs = .overview

    
    var body: some View {
        VStack {
            HStack {
                tabItem(title: "Overview", tab: .overview)
                tabItem(title: type == "movie" ? "Reviews" : "Episodes", tab: type == "movie" ? .reviews : .episodes)
                tabItem(title: "Cast", tab: .cast)
            }
            switch chosenTab {
            case .overview:
                Overview(details: details?.overview ?? "")
            case .reviews:
                ReviewsView(reviews: reviews)
            case .episodes:
                Text("Episodes")
            case .cast:
                Cast(cast: cast)
            }
        }
    }
    
    @ViewBuilder
    private func tabItem(title: String, tab: Tabs) -> some View {
        VStack {
            Text(title)
                .font(.headline)
            if chosenTab == tab {
                Rectangle()
                    .fill(.gray)
                    .frame(maxWidth: .infinity)
                    .frame(height: 2)
            }
        }
        .frame(width: geometry.size.width * 0.3)
        .onTapGesture {
            withAnimation {
                chosenTab = tab
            }
        }
    }
}
