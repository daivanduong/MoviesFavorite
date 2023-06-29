//
//  MovieModel.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import Foundation

class MovieAPI: Codable {
    var resultCount: Int?
    var results: [Movie]?
}

class Movie: Codable {
    var trackId: Int?
    var artistName: String?
    var trackName: String?
    var previewUrl: String?
    var artworkUrl100: String?
    var collectionPrice: Double?
    var primaryGenreName: String?
    var releaseDate: String?
    var longDescription: String?
    
}
