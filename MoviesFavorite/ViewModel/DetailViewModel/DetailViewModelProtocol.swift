//
//  DetailViewModelProtocol.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import Foundation

protocol DetailViewModelProtocol {
    func getDataInMovieDetail(indexPath: IndexPath) -> (trackName: String, primaryGenre:String, year: Int, price: Double, imgURL: URL )
    func getDescription() -> String
    func getUrlVideoPreview() -> URL
    func isHiddenButtonLike() -> Bool
    func saveMovieToFavorite(indexPath: IndexPath)
}
