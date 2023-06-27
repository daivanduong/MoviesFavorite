//
//  DetailViewModelProtocol.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var reloadUI: (() -> ())? {get set}
    func getData()
    func getDataInMovie(indexPath: IndexPath) -> (name: String, primaryGenre:String, year: Int, price: Double, imgURL: URL )
    func getDescription() -> String
    func getUrlVideo() -> URL
    func saveMovieToFavorite(indexPath: IndexPath)
    func checkItemForFavorite() -> String
}
