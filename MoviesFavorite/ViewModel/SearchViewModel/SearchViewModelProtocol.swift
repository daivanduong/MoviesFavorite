//
//  SearchViewModelProtocol.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import Foundation

protocol SearchViewModelProtocol {
    var reloadUI: (() -> ())? { get set }
    func getTitle() -> String
    func callAPI()
    func showNotification() -> Bool
    func numberOfRowsInSection(section: Int) -> Int
    func getDataFromApi(indexPath: IndexPath) -> (trackName: String, primaryGenre:String, year: Int, price: Double, imgURL: URL )
    func getDataItemDetail(indexPath: IndexPath) -> Movie
    func urlComponents(url: URL, titleSearch: String) -> URL
    func checkItemForFavorite(indexPath: IndexPath) -> String
    func saveMovieToFavorite(indexPath: IndexPath)
    
}
