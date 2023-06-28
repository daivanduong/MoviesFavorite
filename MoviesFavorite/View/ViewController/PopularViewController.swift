//
//  PopularViewController.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 26/06/2023.
//

import UIKit

class PopularViewController: UIViewController {
    
    
    var viewModel: PopularViewModelProtocol = PopularViewMoel()
    let searchControler = UISearchController(searchResultsController: nil)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeOpenedLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        setupView()
        setupNavigatitonBar()
        //updateSearchResults(for: searchControler)
    }
    func setupNavigatitonBar() {
        title = "Search"
        searchControler.searchResultsUpdater = self
        searchControler.obscuresBackgroundDuringPresentation = false
        searchControler.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchControler
        searchControler.searchBar.searchTextField.delegate = self
        
    }

    func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TitleMoviePopularViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "titleMoviePopularViewCell")
        
        timeOpenedLb.text = "Last visited: \(viewModel.getLastTimeOpenApp()) minute ago"
    }
    

}
extension PopularViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        
//        let vc = searchController.searchResultsController as! SearchViewController
//        vc.viewModel.callAPI()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // To do: Implement search method
    }
}

extension PopularViewController: UISearchTextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "searchViewController") as! SearchViewController
        if textField.text != "" {
            let vm = SearchViewModel(titleMovie: textField.text!)
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
        let vm = SearchViewModel(titleMovie: viewModel.getTitleMoviePopular(indexPath: indexPath))
        vc.viewModel = vm
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
