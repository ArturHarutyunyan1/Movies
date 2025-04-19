//
//  DetailsView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 31.03.25.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject private var apiManager: ApiManager
    @EnvironmentObject private var databaseManager: DatabaseManager
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @State private var isBookmarked: Bool = false
    var id: Int
    var type: String
    var body: some View {
        GeometryReader { geometry in
            ScrollView (.vertical, showsIndicators: false) {
                if let details = apiManager.details {
                    ZStack {
                        AsyncImage(url: URL(string: "\(apiManager.posterPath)/w1280/\(details.poster_path)")) {result in
                            result
                                .resizable()
                                .frame(height: geometry.size.height * 0.8)
                                .scaledToFit()
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .frame(height: geometry.size.height * 0.8)
                    VStack {
                        VStack {
//                            MARK: - Rating, bookmark
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                Text("\(details.vote_average, specifier: "%.1f")")
                                Spacer()
                                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                    .foregroundStyle(isBookmarked ? .yellow : .white)
                                    .onTapGesture {
                                        if !isBookmarked {
                                            databaseManager.addToBookmarks(path: details.poster_path, id: details.id, title: details.original_title, email: authenticationManager.user?.email ?? "null", type: type)
                                            isBookmarked = true
                                        } else {
                                            databaseManager.removeFromBookmarks(id: id, email: authenticationManager.user?.email ?? "null")
                                            isBookmarked = false
                                        }
                                    }
                            }
//                           MARK: - Title, tagline
                            HStack {
                                VStack {
                                    HStack {
                                        Text("\(details.original_title)")
                                            .font(.custom("Poppins-Bold", size: 36))
                                        Spacer()
                                    }
                                    HStack {
                                        Text("\(details.tagline)")
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
//                            MARK: - Date,Runtime
                            HStack {
                                HStack {
                                    Image(systemName: "calendar")
                                    Text(getDate(dateString: details.release_date))
                                }
                                HStack {
                                    Image(systemName: "clock")
                                    Text(minutesToHours(time: details.runtime))
                                }
                                Spacer()
                            }
//                            MARK: - Genres
                            HStack {
                                ForEach(details.genres, id: \.id) {genre in
                                    Text("\(genre.name) ")
                                }
                                Spacer()
                            }
//                            MARK: - Overview
                            HStack {
                                VStack {
                                    HStack {
                                        Rectangle()
                                            .frame(width: 5, height: 10)
                                            .background(.yellow)
                                        Text("Overview")
                                            .font(.custom("Poppins-semibold", size: 17))
                                        Spacer()
                                    }
                                    Text("\(details.overview)")
                                }
                                Spacer()
                            }
//                            MARK: - Cast
                            if let cast = apiManager.cast {
                                HStack {
                                    Cast(cast: cast)
                                    Spacer()
                                }
                            }
                            if let media = apiManager.media, media.posters.count > 0 {
                                MediaView(media: media)
                            }
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.9)
                        Spacer()
                    }
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height * 0.5)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
                    .padding(.top, -geometry.size.height * 0.1)
                }
                else {
                    NotFound(geometry: geometry)
                }
                Credit(geometry: geometry)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .background(.customBlue)
        .navigationBarBackButtonHidden()
        .onAppear {
            Task {
                apiManager.details = nil
                apiManager.cast = nil
                apiManager.media = nil
                await apiManager.getDetails(for: id, with: type)
                await apiManager.getCast(for: id, with: type)
                await apiManager.getMedia(for: id, type: type)
                databaseManager.isMovieInBookmarks(id: id, email: authenticationManager.user?.email ?? "") {exist in
                    if exist {
                        isBookmarked = true
                    }
                }
            }
        }
    }
    private func getDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateStyle = .long
            let dateText = dateFormatter.string(from: date)
            return dateText
        }
        return "Wrong date"
    }
    private func minutesToHours(time: Int) -> String {
        let hour = time / 60
        let minutes = time % 60
        
        return "\(hour)h \(minutes)m"
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
