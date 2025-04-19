//
//  BottomBar.swift
//  Movies
//
//  Created by Artur Harutyunyan on 02.04.25.
//

import SwiftUI

enum Views {
    case movies
    case shows
    case saved
    case search
}

struct BottomBar: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    var geometry: GeometryProxy
    @Binding var chosenView: Views
    @State private var showAlert: Bool = false

    var body: some View {
        HStack(spacing: 0) {
            bottomBarItem(icon: "movieclapper", selectedIcon: "movieclapper.fill", title: "Movies", isSelected: chosenView == .movies) {
                chosenView = .movies
            }

            bottomBarItem(icon: "tv", selectedIcon: "tv.fill", title: "Shows", isSelected: chosenView == .shows) {
                chosenView = .shows
            }

            bottomBarItem(icon: "bookmark", selectedIcon: "bookmark.fill", title: "Bookmarks", isSelected: chosenView == .saved) {
                chosenView = .saved
            }

            VStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 20))
                Text("Logout")
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.red)
            .contentShape(Rectangle())
            .onTapGesture {
                showAlert = true
            }
        }
        .padding(.vertical, 50)
        .padding(.horizontal)
        .frame(width: geometry.size.width)
        .alert("Are you sure you want to log out?", isPresented: $showAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Yes") {
                authenticationManager.signOut()
            }
        }
    }

    @ViewBuilder
    private func bottomBarItem(icon: String, selectedIcon: String, title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        VStack {
            Image(systemName: isSelected ? selectedIcon : icon)
                .font(.system(size: 20))
            Text(title)
                .font(.caption2)
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(isSelected ? .foregroundBlue : .white)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                action()
            }
        }
    }
}
