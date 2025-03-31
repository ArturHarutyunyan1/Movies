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
        var genre_ids: [Int]
        var original_language: String
        var original_title: String
        var overview: String
        var vote_average: Double
        var vote_count: Int
    }
    var results: [Results]
}
