//
//  DetailViewModel.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import Foundation

class DetailViewModel: DetailViewModelProtocol {
    var reloadUI: (() -> ())?
    var movie = [Movie]()
    
    func getData() {
        if let data = UserDefaults.standard.data(forKey: "MovieDetail") {
            movie = try! PropertyListDecoder().decode([Movie].self, from: data)
            self.reloadUI?()
        }
    }
    func getDataInMovie(indexPath: IndexPath) -> (name: String, primaryGenre: String, year: Int, price: Double, imgURL: URL) {
        let name = movie[indexPath.row].collectionName
        let primaryGenre = movie[indexPath.row].primaryGenreName
        let year = covertStringToDate(string: movie[indexPath.row].releaseDate ?? "")
        let price = movie[indexPath.row].collectionPrice ?? 0.0
        let UrlDefaults = URL(string: "https://placehold.co/100")!
        let url = URL(string: "\(movie[indexPath.row].artworkUrl100 ?? "")") ?? UrlDefaults
        
        
        
        return (name ?? "", primaryGenre ?? "", year, price, url)
    }
    
    func getDescription() -> String {
        return movie.first?.longDescription ?? ""
    }
    
    func getUrlVideo() -> URL {
        let url1 = URL(string: "ghgh")
        let url = URL(string: movie.first?.previewUrl ?? "")
        return url ?? url1!
    }
    func saveMovieToFavorite(indexPath: IndexPath) {
        let data = movie[indexPath.row]
        if let dataFavorite = UserDefaults.standard.data(forKey: "MovieFavorite") {
            movie = try! PropertyListDecoder().decode([Movie].self, from: dataFavorite)
            let movieDeatil = Movie(trackId: data.trackId, artistName: data.artistName, collectionName: data.collectionName, previewUrl: data.previewUrl, artworkUrl100: data.artworkUrl100, collectionPrice: data.collectionPrice, primaryGenreName: data.primaryGenreName, releaseDate: data.releaseDate, longDescription: data.longDescription)
            movie.append(movieDeatil)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(movie), forKey: "MovieFavorite")
        } else {
            let movieDeatil = Movie(trackId: data.trackId, artistName: data.artistName, collectionName: data.collectionName, previewUrl: data.previewUrl, artworkUrl100: data.artworkUrl100, collectionPrice: data.collectionPrice, primaryGenreName: data.primaryGenreName, releaseDate: data.releaseDate, longDescription: data.longDescription)
            var arrMovie = [Movie]()
            arrMovie.append(movieDeatil)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(movie), forKey: "MovieFavorite")
        }
        
    }
    
    
    func covertStringToDate(string: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        return components.year ?? 0
    }
    func checkItemForFavorite() -> String {
        if let dataFavorite = UserDefaults.standard.data(forKey: "MovieFavorite") {
            let movieFavorite = try! PropertyListDecoder().decode([Movie].self, from: dataFavorite)
            let check_unique = movieFavorite.contains(where: { MovieFavorite in
                MovieFavorite.trackId == movie.first?.trackId
            })
            if check_unique == true {
                return "Liked"
            }
        }
        return "Like"
    }
    
}
