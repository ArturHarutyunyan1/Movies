//
//  Structures.swift
//  Movies
//
//  Created by Artur Harutyunyan on 31.03.25.
//

import Foundation

struct Popular: Codable {
    struct Results: Codable {
        var id: Int
        var backdrop_path: String
        var poster_path: String
        var genre_ids: [Int]
        var original_language: String
        var title: String
        var overview: String
        var vote_average: Double
        var vote_count: Int
    }
    var results: [Results]
}

struct Details: Codable {
    struct Genres: Codable {
        var id: Int
        var name: String
    }
    var backdrop_path: String
    var genres: [Genres]
    var id: Int
    var origin_country: [String]
    var original_language: String
    var original_title: String
    var overview: String
    var poster_path: String
    var release_date: String
    var runtime: Int
    var status: String
    var tagline: String
    var vote_average: Double
    var vote_count: Int
}

struct Reviews: Codable {
    struct ReviewResult: Codable {
        struct AuthorDetails: Codable {
            var name: String?
            var username: String
            var avatar_path: String?
            var rating: Double?
        }

        var author: String
        var author_details: AuthorDetails
        var content: String
        var created_at: String
        var id: String
        var updated_at: String
        var url: String
    }
    
    var id: Int
    var page: Int
    var results: [ReviewResult]
    var total_pages: Int
    var total_results: Int
}

struct CastResults: Codable {
    struct Cast: Codable {
        var id: Int
        var known_for_department: String
        var name: String
        var popularity: Double
        var profile_path: String?
        var character: String
    }
    var cast: [Cast]
    var id: Int
}
