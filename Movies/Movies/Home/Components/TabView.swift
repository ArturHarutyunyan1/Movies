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
    case cast
}

struct TabViewModel: View {
    var details: Details
    var reviews: Reviews
    @State private var chosenTab: Tabs = .overview
    
    var body: some View {
        VStack {
            VStack {
                tabItem(title: "Overview", tab: .overview)
                tabItem(title: "Reviews", tab: .reviews)
                tabItem(title: "Cast", tab: .cast)
            }
            switch chosenTab {
            case .overview:
                Overview(details: details.overview)
            case .reviews:
                ReviewsView(reviews: reviews)
            case .cast:
                Overview(details: details.overview)
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
        .onTapGesture {
            withAnimation {
                chosenTab = tab
            }
        }
    }
}
