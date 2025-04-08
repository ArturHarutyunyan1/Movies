////
////  Details.swift
////  Movies
////
////  Created by Artur Harutyunyan on 09.04.25.
////
//
//import SwiftUI
//
//struct DetailsContent: View {
//    @EnvironmentObject private var apiManager: ApiManager
//    var details: Details?
//    var showDetails: ShowDetails?
//    var geometry: GeometryProxy
//    var body: some View {
//        ZStack {
//            AsyncImage(url: URL(string: "\(apiManager.posterPath)/w1280/\(details?.poster_path)")) {result in
//                result
//                    .resizable()
//                    .frame(height: geometry.size.height * 0.8)
//                    .scaledToFit()
//                    .clipped()
//            } placeholder: {
//                ProgressView()
//            }
//        }
//        .frame(height: geometry.size.height * 0.8)
//        VStack {
//            VStack {
//                Text("\(details)")
//                //                            MARK: - Rating
//                HStack {
//                    Image(systemName: "star.fill")
//                        .foregroundStyle(.yellow)
//                    Text("\(details?.vote_average, specifier: "%.1f")")
//                    Spacer()
//                }
//                //                           MARK: - Title, tagline
//                HStack {
//                    VStack {
//                        HStack {
//                            Text("\(details.original_title)")
//                                .font(.custom("Poppins-Bold", size: 36))
//                            Spacer()
//                        }
//                        HStack {
//                            Text("\(details.tagline)")
//                            Spacer()
//                        }
//                    }
//                    Spacer()
//                }
//                //                            MARK: - Date,Runtime
//                HStack {
//                    HStack {
//                        Image(systemName: "calendar")
//                        Text(getDate(dateString: details.release_date))
//                    }
//                    HStack {
//                        Image(systemName: "clock")
//                        Text(minutesToHours(time: details.runtime))
//                    }
//                    Spacer()
//                }
//                //                            MARK: - Genres
//                HStack {
//                    ForEach(details.genres, id: \.id) {genre in
//                        Text("\(genre.name) ")
//                    }
//                    Spacer()
//                }
//                //                            MARK: - Overview
//                HStack {
//                    VStack {
//                        HStack {
//                            Rectangle()
//                                .frame(width: 5, height: 10)
//                                .background(.yellow)
//                            Text("Overview")
//                                .font(.custom("Poppins-semibold", size: 17))
//                            Spacer()
//                        }
//                        Text("\(details.overview)")
//                    }
//                    Spacer()
//                }
//                //                            MARK: - Cast
//                if let cast = apiManager.cast {
//                    HStack {
//                        Cast(cast: cast)
//                        Spacer()
//                    }
//                }
//            }
//            .padding()
//            .frame(width: geometry.size.width * 0.9)
//            Spacer()
//        }
//        .frame(width: geometry.size.width)
//        .frame(minHeight: geometry.size.height * 0.5)
//        .background(.ultraThinMaterial)
//        .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
//        .padding(.top, -geometry.size.height * 0.1)
//    }
//    private func getDate(dateString: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        
//        if let date = dateFormatter.date(from: dateString) {
//            dateFormatter.dateStyle = .long
//            let dateText = dateFormatter.string(from: date)
//            return dateText
//        }
//        return "Wrong date"
//    }
//    private func minutesToHours(time: Int) -> String {
//        let hour = time / 60
//        let minutes = time % 60
//        
//        return "\(hour)h \(minutes)m"
//    }
//}
//
//struct RoundedCorner: Shape {
//    var radius: CGFloat
//    var corners: UIRectCorner
//
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        return Path(path.cgPath)
//    }
//}
