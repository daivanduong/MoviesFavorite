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
    
    func getLastTimeOpenApp() -> String {
        if let lastOpened = UserDefaults.standard.object(forKey: "LastOpened") as? Date {
            let elapsed = Calendar.current.dateComponents([.hour, .minute], from: lastOpened, to: Date())
            if elapsed.minute ?? 0 < 60 {
                return "Last visited: \(elapsed.minute!) minute ago "
            }
            return "Last visited: \(elapsed.hour!) hour ago "
        }
        return ""
    }
    
}
