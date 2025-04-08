//
//  SearchView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 02.04.25.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var apiManager: ApiManager
    @State private var searchText: String = ""
    @State private var isActive: Bool = false
    @State private var navigateTo: Bool = false
    var geometry: GeometryProxy
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("", text: $searchText, prompt: Text("Search for a movie, series or a person").foregroundStyle(.white))
                    .onSubmit {
                        if searchText.count > 0 {
                            Task {
                                await apiManager.getSearchResults(for: searchText)
                            }
                            navigateTo = true
                        }
                    }
                Spacer()
                if isActive {
                    Image(systemName: "x.circle")
                        .onTapGesture {
                            searchText = ""
                            isActive = false
                        }
                }
            }
            .frame(width: geometry.size.width * 0.9, height: 50)
        }
        .frame(width: geometry.size.width, height: 50)
        .background(.customBlue)
        .navigationDestination(isPresented: $navigateTo) {
            SearchResultsView()
        }
        .onChange(of: searchText) {
            if searchText.count > 0 {
                isActive = true
            } else {
                isActive = false
            }
        }
    }
}
