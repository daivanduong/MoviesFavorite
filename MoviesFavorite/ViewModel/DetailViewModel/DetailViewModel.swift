//
//  DetailViewModel.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import Foundation

class DetailViewModel: DetailViewModelProtocol {
    private var movie: Movie?
    
    init (movie: Movie) {
        self.movie = movie
    }
    
    func getDataInMovieDetail(indexPath: IndexPath) -> (trackName: String, primaryGenre: String, year: Int, price: Double, imgURL: URL) {
        let trackName = movie?.trackName
        let primaryGenre = movie?.primaryGenreName
        let year = covertStringToDate(string: movie?.releaseDate ?? "")
        let price = movie?.collectionPrice ?? 0.0
        let UrlDefaults = URL(string: "https://placehold.co/100")!
        let url = URL(string: "\(movie?.artworkUrl100 ?? "")") ?? UrlDefaults
        
        return (trackName ?? "", primaryGenre ?? "", year, price, url)
    }
    
    func getDescription() -> String {
        return movie?.longDescription ?? ""
    }
    
    func getUrlVideoPreview() -> URL {
        let urlDefaults = URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/ef/0c/4d/ef0c4d9a-96ce-89df-4728-ea7fb457cd24/mzaf_12472414507465824718.plus.aac.p.m4a")
        let url = URL(string: movie?.previewUrl ?? "")
        return url ?? urlDefaults!
    }
    
    func isHiddenButtonLike() -> Bool {
        if let dataFavorite = UserDefaults.standard.data(forKey: "MovieFavorite") {
            let movieFavorite = try! PropertyListDecoder().decode([Movie].self, from: dataFavorite)
            let check_unique = movieFavorite.contains(where: { MovieFavorite in
                MovieFavorite.trackId == movie?.trackId
            })
            if check_unique == true {
                return true
            }
        }
        return false
    }
    
    func saveMovieToFavorite(indexPath: IndexPath) {
        if let dataFavorite = UserDefaults.standard.data(forKey: "MovieFavorite") {
            var movieFavorite = try! PropertyListDecoder().decode([Movie].self, from: dataFavorite)
            let checkUniqueItemInFavorites = movieFavorite.contains(where: { MovieFavorite in
                MovieFavorite.trackId == movie?.trackId
            })
            if checkUniqueItemInFavorites == false {
                movieFavorite.insert(movie!, at: 0)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(movieFavorite), forKey: "MovieFavorite")
            }
        } else {
            var arrMovies = [Movie]()
            arrMovies.insert(movie!, at: 0)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(arrMovies), forKey: "MovieFavorite")
        }
        
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
