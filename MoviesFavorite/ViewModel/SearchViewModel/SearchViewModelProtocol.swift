//
//  SearchViewModelProtocol.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import Foundation

protocol SearchViewModelProtocol {
    var reloadUI: (() -> ())? { get set }
    func callAPI()
    func showNotification() -> Bool
    func numberOfRowsInSection(section: Int) -> Int
    func getDataFromApi(indexPath: IndexPath) -> (name: String, primaryGenre:String, year: Int, price: Double, imgURL: URL )
    func getDataFordetail(indexPath: IndexPath)
    func urlComponents(url: URL, categories: String) -> URL
    func checkItemForFavorite(indexPath: IndexPath) -> String
    func saveMovieToFavorite(indexPath: IndexPath)
    
}
