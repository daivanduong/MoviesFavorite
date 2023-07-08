//
//  SearchResultsViewController.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 04/07/2023.
//

import UIKit

class SearchResultsViewController: UITableViewController {
    
    var arrActionMovieTitles: [String] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SearchStringSuggestViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "searchStringSuggestViewCell")
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrActionMovieTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchStringSuggestViewCell", for: indexPath) as! SearchStringSuggestViewCell
        cell.titleMoviePopular.text = arrActionMovieTitles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selecteTitledMovie = arrActionMovieTitles[indexPath.row]
        
        if let searchViewController = presentingViewController as? PopularViewController {
            searchViewController.searchController.searchBar.text = selecteTitledMovie
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "searchViewController") as! SearchViewController
        let vm = SearchViewModel(titleSearch: selecteTitledMovie)
        vc.viewModel = vm
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Navigation



}
