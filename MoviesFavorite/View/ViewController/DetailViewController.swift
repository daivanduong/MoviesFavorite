//
//  DetailViewController.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import UIKit
import AVKit
import AVFoundation

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModelProtocol!

    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descriptionLb: UILabel!
    
    var player: AVPlayer!
    var avpController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail"
        setupView()
        setupVideoView()
        setupNavigationItem()
    }
    
    func setupNavigationItem() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<Back", style: .plain, target: self, action: #selector(DetailViewController.pauseVideo(sender:)))
    }
    @objc func pauseVideo(sender: UIBarButtonItem) {
        player.pause()
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        viewModel.reloadUI = {
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "MovieViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "movieViewCell")
        
        descriptionLb.text = viewModel.getDescription()

    }
    
    func setupVideoView() {
        videoView.layer.cornerRadius = 10
        videoView.layer.masksToBounds = true
        player = AVPlayer(url: viewModel.getUrlVideo())

        avpController.player = player

        avpController.view.frame.size.height = videoView.frame.size.height

        avpController.view.frame.size.width = videoView.frame.size.width

        self.videoView.addSubview(avpController.view)
        player.play()
        
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieViewCell", for: indexPath) as! MovieViewCell
        cell.name.text = viewModel.getDataInMovieDetail(indexPath: indexPath).name
        cell.primaryGenre.text = viewModel.getDataInMovieDetail(indexPath: indexPath).primaryGenre
        cell.year.text = "\(viewModel.getDataInMovieDetail(indexPath: indexPath).year)"
        cell.price.text = "$\(viewModel.getDataInMovieDetail(indexPath: indexPath).price)"
        cell.imgThumb.sd_setImage(with: viewModel.getDataInMovieDetail(indexPath: indexPath).imgURL, placeholderImage: UIImage(named: "placeholder.png"))
        
        cell.likeBtn = {[ unowned self] in
            viewModel.saveMovieToFavorite(indexPath: indexPath)
        }
        cell.likeButton.setTitle(viewModel.checkItemForFavorites(), for: .normal)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
