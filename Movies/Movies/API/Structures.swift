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
    struct Results: Codable {
        var author: String
        var rating: Double
    }
    var id: Int
    var content: String
    var results: [Results]
    
}
