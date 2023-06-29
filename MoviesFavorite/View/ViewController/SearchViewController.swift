//
//  SearchViewController.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModelProtocol!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func setupView() {
        viewNotification.isHidden = true
        viewModel.callAPI()
        activityIndicator.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(nibName: "MovieViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "movieViewCell")

        viewModel.reloadUI = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.viewNotification.isHidden = self.viewModel.showNotification()
                self.tableView.reloadData()
            }
        }
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieViewCell", for: indexPath) as! MovieViewCell
        cell.trackName.text = viewModel.getDataFromApi(indexPath: indexPath).trackName
        cell.primaryGenre.text = viewModel.getDataFromApi(indexPath: indexPath).primaryGenre
        cell.year.text = "\(viewModel.getDataFromApi(indexPath: indexPath).year)"
        cell.price.text = "$\(viewModel.getDataFromApi(indexPath: indexPath).price)"
        cell.imgThumb.sd_setImage(with: viewModel.getDataFromApi(indexPath: indexPath).imgURL, placeholderImage: UIImage(named: "placeholder.png"))
        cell.likeBtn = {[ unowned self] in
            viewModel.saveMovieToFavorite(indexPath: indexPath)
        }
        cell.likeButton.setTitle(viewModel.checkItemForFavorite(indexPath: indexPath), for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "detailViewController") as! DetailViewController
        let vm = DetailViewModel(movie: viewModel.getDataItemDetail(indexPath: indexPath))
        vc.viewModel = vm        
        navigationController?.pushViewController(vc, animated: true)
    }
 
}


