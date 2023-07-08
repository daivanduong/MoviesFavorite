//
//  PopularViewModel.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 26/06/2023.
//

import Foundation

class PopularViewMoel: PopularViewModelProtocol {
    
    var arr: [String]?
    var arrTitleMoviePopular = ["Star Wars", "X-Men", "Avatar", "The Flash", "Extraction", "Spider-Man", "Transformers", "The Avengers", "Iron-Man"]
    
    let arrActionMovieTitles = [ "Die Hard", "The Terminator", "Lethal Weapon", "Mad Max: Fury Road", "John Wick", "The Dark Knight", "The Matrix", "Inception", "Kill Bill", "Mission: Impossible", "Taken", "Gladiator", "Black Panther", "The Avengers", "Jurassic Park", "Braveheart", "The Fast and the Furious", "Rambo", "Edge of Tomorrow", "The Bourne Identity", "Mad Max", "Predator", "RoboCop", "The Expendables", "Indiana Jones and the Raiders of the Lost Ark", "The Mummy", "Face/Off", "The Rock", "Iron Man", "Captain America: The Winter Soldier", "The Raid", "The Equalizer", "Transformers", "The Incredible Hulk", "Rush Hour", "Baby Driver", "Man of Steel", "Point Break", "The Transporter", "The Dark Knight Rises", "Speed", "Con Air", "The A-Team", "Predators", "The Italian Job", "X-Men", "The Great Wall", "Kingsman: The Secret Service", "Mad Max 2: The Road Warrior", "Blade Runner", "Die Hard with a Vengeance", "Salt", "Black Hawk Down", "Jack Reacher", "Tomb Raider", "Hellboy", "Atomic Blonde", "Dredd", "G.I. Joe: The Rise of Cobra", "The Fate of the Furious", "Avengers: Infinity War", "Star Wars: The Force Awakens", "Spider-Man: Homecoming", "Wonder Woman", "Guardians of the Galaxy", "Thor: Ragnarok", "Captain Marvel", "The Hunger Games", "John Carter", "Pacific Rim", "Skyfall", "Spectre", "Salt", "White House Down", "London Has Fallen", "The Expendables 2", "Underworld", "Resident Evil", "I Am Legend", "The Purge", "Snowpiercer", "The Meg", "Battleship", "Battle: Los Angeles", "The Last Samurai", "The Hunt for Red October", "Zero Dark Thirty", "The Equalizer 2", "Man on Fire", "Taken 2", "The Kingdom", "Deepwater Horizon", "Olympus Has Fallen", "Non-Stop", "Looper", "John Wick: Chapter 2", "Fast & Furious", "Ant-Man", "Captain America: Civil War", "Doctor Strange", "Thor: The Dark World" ]
    
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
    
    func getArraySuggestName(searchText: String) -> [String] {
       
        arr = arrActionMovieTitles.filter { $0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchText.replacingOccurrences(of: " ", with: "").lowercased())}
        return arr ?? []
        
    }
}
