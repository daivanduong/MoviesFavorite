//
//  PopularViewModel.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 26/06/2023.
//

import Foundation

class PopularViewMoel: PopularViewModelProtocol {
    var reloaUI: (() -> ())?
    var arrTitleMoviePopular = ["Star Wars", "X-Men", "Avatar", "The Flash", "Extraction", "Spider-Man", "Transformers", "The Avengers", "Iron-Man"]
    var selectedItem: IndexPath?
    func numberOfRowsInSection(section: Int) -> Int {
        return arrTitleMoviePopular.count
    }
    func getTitleMoviePopular(indexPath: IndexPath) -> String {
        return arrTitleMoviePopular[indexPath.row]
    }
    func getLastTimeOpenApp() -> Int {
        guard let lastOpened = UserDefaults.standard.object(forKey: "LastOpened") as? Date else {
            return 0
        }
        let elapsed = Calendar.current.dateComponents([.minute], from: lastOpened, to: Date())
        
        
        return elapsed.minute ?? 0
    }
    
    
    
}
