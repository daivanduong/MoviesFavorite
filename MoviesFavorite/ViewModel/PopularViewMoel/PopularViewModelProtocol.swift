//
//  PopularViewModelProtocol.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 26/06/2023.
//

import Foundation

protocol PopularViewModelProtocol {
    var reloaUI: (() -> ())? { get set }
    func numberOfRowsInSection(section: Int) -> Int
    func getTitleMoviePopular(indexPath: IndexPath) -> String
    func getLastTimeOpenApp() -> Int
}
