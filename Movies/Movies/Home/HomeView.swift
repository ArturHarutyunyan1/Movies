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
        VStack {
            if !apiManager.errorMessage.isEmpty {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text("\(authenticationManager.errorMessage)")
                }
                .padding()
                .background(.red)
                .cornerRadius(8)
                .foregroundStyle(.white)
            }
            Button(action: {
                authenticationManager.signOut()
            }, label: {
                Text("Log out")
            })
        }
        .onAppear {
            Task {
                await apiManager.getPopularMovies()
            }
        }
    }
}

#Preview {
    HomeView()
}
