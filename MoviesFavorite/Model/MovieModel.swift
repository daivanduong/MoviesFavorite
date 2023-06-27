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
    var collectionName: String?
    var previewUrl: String?
    var artworkUrl100: String?
    var collectionPrice: Double?
    var primaryGenreName: String?
    var releaseDate: String?
    var longDescription: String?
    
    init(trackId: Int? = nil, artistName: String? = nil, collectionName: String? = nil, previewUrl: String? = nil, artworkUrl100: String? = nil, collectionPrice: Double? = nil, primaryGenreName: String? = nil, releaseDate: String? = nil, longDescription: String? = nil) {
        self.trackId = trackId
        self.artistName = artistName
        self.collectionName = collectionName
        self.previewUrl = previewUrl
        self.artworkUrl100 = artworkUrl100
        self.collectionPrice = collectionPrice
        self.primaryGenreName = primaryGenreName
        self.releaseDate = releaseDate
        self.longDescription = longDescription
    }
}
