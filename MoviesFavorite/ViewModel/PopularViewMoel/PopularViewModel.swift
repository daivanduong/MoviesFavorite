//
//  PopularViewModel.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 26/06/2023.
//

import Foundation

class PopularViewMoel: PopularViewModelProtocol {
    var reloaUI: (() -> ())?
    var arrTitleMoviePopular = ["Star Wars", "X-men", "Avatar", "The Flash", "Extraction", "Spider-Man", "Transformers"]
    var selectedItem: IndexPath?
    func numberOfRowsInSection(section: Int) -> Int {
        return arrTitleMoviePopular.count
    }
    func getTitleMoviePopular(indexPath: IndexPath) -> String {
        return arrTitleMoviePopular[indexPath.row]
    }
    
    
    
}
