//
//  SearchViewModel.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import Foundation

class SearchViewModel: SearchViewModelProtocol {
    private var movie: MovieAPI?
    private var movieFavorite = [Movie]()
    private var titleMovie: String?
    private var check = true
    var reloadUI: (() -> ())?
    
    init(titleMovie: String?) {
        self.titleMovie = titleMovie
    }
    
    func callAPI() {
        let url = URL(string: "https://itunes.apple.com/search")
        URLSession.shared.dataTask(with: urlComponents(url: url!, categories: titleMovie!)) { [weak self] data, response , error in
            if let data = data {
                let movielData = try? JSONDecoder().decode(MovieAPI.self, from: data)
                if movielData != nil {
                    self?.movie = movielData
                } else {
                    self?.check = false
                }
                if movielData?.resultCount == 0 {
                    self?.check = false
                }
                self?.reloadUI?()
            }
        } .resume()
    }
    func showNotification() -> Bool {
        return check
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return movie?.results?.count ?? 0
    }
    
    func getDataFromApi(indexPath: IndexPath) -> (name: String, primaryGenre: String, year: Int, price: Double, imgURL: URL) {
        let name = movie?.results?[indexPath.row].collectionName
        let primaryGenre = movie?.results?[indexPath.row].primaryGenreName
        let year = covertStringToDate(string: movie?.results?[indexPath.row].releaseDate ?? "")
        let price = movie?.results?[indexPath.row].collectionPrice ?? 0.0
        let UrlDefaults = URL(string: "https://placehold.co/100")!
        let url = URL(string: "\(movie?.results?[indexPath.row].artworkUrl100 ?? "")") ?? UrlDefaults
        return (name ?? "", primaryGenre ?? "", year, price, url)
    }
    
    func getDataItemDetail(indexPath: IndexPath) -> Movie {
        let data = movie?.results?[indexPath.row]
        return data!
    }
    
    func urlComponents(url: URL, categories: String) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItemCategories = URLQueryItem(name: "term", value: categories)
        components?.queryItems = [queryItemCategories]
        return (components?.url)!
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
    func saveMovieToFavorite(indexPath: IndexPath) {
        let data = movie?.results?[indexPath.row]
        
        if let dataFavorite = UserDefaults.standard.data(forKey: "MovieFavorite") {
            var movieFavorite = try! PropertyListDecoder().decode([Movie].self, from: dataFavorite)
            let checkUniqueItemInFavorites = movieFavorite.contains(where: { MovieFavorite in
                MovieFavorite.trackId == data?.trackId
            })
            if checkUniqueItemInFavorites == false {
                movieFavorite.append(data!)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(movieFavorite), forKey: "MovieFavorite")
            }
            
        } else {
            var movieFavorite = [Movie]()
            movieFavorite.append(data!)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(movieFavorite), forKey: "MovieFavorite")
        }
        
    }
    
    func checkItemForFavorite(indexPath: IndexPath) -> String {
        if let dataFavorite = UserDefaults.standard.data(forKey: "MovieFavorite") {
            movieFavorite = try! PropertyListDecoder().decode([Movie].self, from: dataFavorite)
            let checkUniqueItemInFavorites = movieFavorite.contains(where: { MovieFavorite in
                MovieFavorite.trackId == movie?.results?[indexPath.row].trackId
            })
            if checkUniqueItemInFavorites == true {
                return "Liked"
            }
        }
        return "Like"
    }
}
