//
//  FavoriteViewModel.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import Foundation
import UIKit

class FavoriteViewModel: FavoriteViewModelProtocol {
    var reloadUI: (() -> ())?
    private var movie = [Movie]()
    private var check = false
    
    func getData() {
        if let data = UserDefaults.standard.data(forKey: "MovieFavorite") {
            movie = try! PropertyListDecoder().decode([Movie].self, from: data)
            if movie.count != 0 {
                check = true
            }
        }
        reloadUI?()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return movie.count
    }
    
    func getDataInMovie(indexPath: IndexPath) -> (trackName: String, primaryGenre: String, year: Int, price: Double, imgURL: URL) {
        let trackName = movie[indexPath.row].trackName
        let primaryGenre = movie[indexPath.row].primaryGenreName
        let year = covertStringToDate(string: movie[indexPath.row].releaseDate ?? "")
        let price = movie[indexPath.row].collectionPrice ?? 0.0
        let UrlDefaults = URL(string: "https://placehold.co/100")!
        let url = URL(string: "\(movie[indexPath.row].artworkUrl100 ?? "")") ?? UrlDefaults
        return (trackName ?? "", primaryGenre ?? "", year, price, url)
    }
    
    func getDataItemDetail(indexPath: IndexPath) -> Movie {
        return movie[indexPath.row]
    }
    
    func deledeRowFortable(table: UITableView,editingStyle: UITableViewCell.EditingStyle ,index: IndexPath) {
        if editingStyle == .delete {
            table.beginUpdates()
            movie.remove(at: index.row)
            UserDefaults.standard.removeObject(forKey: "MovieFavorite")
            table.deleteRows(at: [index], with: .fade)
            if movie.count != 0 {
                UserDefaults.standard.set(try? PropertyListEncoder().encode(movie), forKey: "MovieFavorite")
            }else {
                check = false
            }
            table.endUpdates()
        }
    }
    
    func showNotification() -> Bool {
        return check
    }
    
    func covertStringToDate(string: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        return components.year ?? 0
    }
    
    
}
