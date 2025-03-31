//
//  HomeView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action: {
                authenticationManager.signOut()
            }, label: {
                Text("Log out")
            })
        }
    }
}

#Preview {
    HomeView()
}
