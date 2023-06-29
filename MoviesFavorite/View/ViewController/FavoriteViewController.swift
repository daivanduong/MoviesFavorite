//
//  FavoriteViewController.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import UIKit

class FavoriteViewController: UIViewController {

    var viewModel: FavoriteViewModelProtocol = FavoriteViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewNotification: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Favorites"
        viewModel.getData()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            viewModel.getData()
            viewNotification.isHidden = viewModel.showNotification()
            viewModel.reloadUI = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "MovieViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "movieViewCell")
        viewModel.reloadUI = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieViewCell", for: indexPath) as! MovieViewCell
        cell.trackName.text = viewModel.getDataInMovie(indexPath: indexPath).trackName
        cell.primaryGenre.text = viewModel.getDataInMovie(indexPath: indexPath).primaryGenre
        cell.year.text = "\(viewModel.getDataInMovie(indexPath: indexPath).year)"
        cell.price.text = "$\(viewModel.getDataInMovie(indexPath: indexPath).price)"
        cell.imgThumb.sd_setImage(with: viewModel.getDataInMovie(indexPath: indexPath).imgURL, placeholderImage: UIImage(named: "placeholder.png"))
        cell.likeButton.isHidden = true
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
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.viewModel.deledeRowFortable(table: tableView, editingStyle: editingStyle, index: indexPath)
        self.viewNotification.isHidden = self.viewModel.showNotification()
    }
 
}
