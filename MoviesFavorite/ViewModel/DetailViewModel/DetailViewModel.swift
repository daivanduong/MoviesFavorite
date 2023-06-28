//
//  DetailViewModel.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import Foundation

class DetailViewModel: DetailViewModelProtocol {
    var reloadUI: (() -> ())?
    private var movie: Movie?
    
    init (movie: Movie) {
        self.movie = movie
    }
    

    func getDataInMovieDetail(indexPath: IndexPath) -> (name: String, primaryGenre: String, year: Int, price: Double, imgURL: URL) {
        let name = movie?.collectionName
        let primaryGenre = movie?.primaryGenreName
        let year = covertStringToDate(string: movie?.releaseDate ?? "")
        let price = movie?.collectionPrice ?? 0.0
        let UrlDefaults = URL(string: "https://placehold.co/100")!
        let url = URL(string: "\(movie?.artworkUrl100 ?? "")") ?? UrlDefaults
        
        
        
        return (name ?? "", primaryGenre ?? "", year, price, url)
    }
    
    func getDescription() -> String {
        return movie?.longDescription ?? ""
    }
    
    func getUrlVideo() -> URL {
        let url1 = URL(string: "ghgh")
        let url = URL(string: movie?.previewUrl ?? "")
        return url ?? url1!
    }
    func saveMovieToFavorite(indexPath: IndexPath) {
        if let dataFavorite = UserDefaults.standard.data(forKey: "MovieFavorite") {
            var arrMovies = try! PropertyListDecoder().decode([Movie].self, from: dataFavorite)
            arrMovies.append(movie!)
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(arrMovies), forKey: "MovieFavorite")
        } else {
            
            var arrMovies = [Movie]()
            arrMovies.append(movie!)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(arrMovies), forKey: "MovieFavorite")
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
    func checkItemForFavorites() -> String {
        if let dataFavorite = UserDefaults.standard.data(forKey: "MovieFavorite") {
            let movieFavorite = try! PropertyListDecoder().decode([Movie].self, from: dataFavorite)
            let check_unique = movieFavorite.contains(where: { MovieFavorite in
                MovieFavorite.trackId == movie?.trackId
            })
            if check_unique == true {
                return "Liked"
            }
        }
        return "Like"
    }
    
}
