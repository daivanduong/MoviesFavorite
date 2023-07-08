//
//  PopularViewController.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 26/06/2023.
//

import UIKit




class PopularViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    var viewModel: PopularViewModelProtocol = PopularViewMoel()
    var searchController: UISearchController!
    var searchResultsController: SearchResultsViewController!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeOpenedLb: UILabel!
    @IBOutlet weak var popularText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupNavigatitonBar()

    }
    
    
    func setupNavigatitonBar() {
        title = "Search"
        searchResultsController = SearchResultsViewController()
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchTextField.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
    }

    func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TitleMoviePopularViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "titleMoviePopularViewCell")
        
        timeOpenedLb.text = viewModel.getLastTimeOpenApp()
    }
    

}
extension PopularViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        searchResultsController.arrActionMovieTitles = viewModel.getArraySuggestName(searchText: searchText)
        searchResultsController.tableView.reloadData()
        
    }
   
}

extension PopularViewController: UISearchTextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "searchViewController") as! SearchViewController
        if textField.text != "" {
            let vm = SearchViewModel(titleSearch: textField.text!)
            vc.viewModel = vm
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleMoviePopularViewCell", for: indexPath) as! TitleMoviePopularViewCell
        cell.titleMoviePopular.text = viewModel.getTitleMoviePopular(indexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "searchViewController") as! SearchViewController
        let vm = SearchViewModel(titleSearch: viewModel.getTitleMoviePopular(indexPath: indexPath))
        vc.viewModel = vm
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
