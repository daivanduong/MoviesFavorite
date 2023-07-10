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
    
//    @IBOutlet weak var videoView: UIView!
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var descriptionLb: UILabel!
    private var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        setupView()
        setupViewPreviewVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        
        let nib = UINib(nibName: "MovieViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "movieViewCell")
        
        descriptionLb.text = viewModel.getDescription()

    }
    
    func setupViewPreviewVideo() {
        videoView.layer.cornerRadius = 10
        videoView.layer.masksToBounds = true
        player = AVPlayer(url: viewModel.getUrlVideoPreview())
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.addChild(playerController)
        self.videoView.addSubview(playerController.view)
        playerController.view.frame.size.height = videoView.frame.size.height
        playerController.view.frame.size.width = videoView.frame.size.width
        playerController.videoGravity = .resizeAspectFill
        player?.play()
       
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieViewCell", for: indexPath) as! MovieViewCell
        cell.trackName.text = viewModel.getDataInMovieDetail(indexPath: indexPath).trackName
        cell.primaryGenre.text = viewModel.getDataInMovieDetail(indexPath: indexPath).primaryGenre
        cell.year.text = "\(viewModel.getDataInMovieDetail(indexPath: indexPath).year)"
        cell.price.text = "$\(viewModel.getDataInMovieDetail(indexPath: indexPath).price)"
        cell.imgThumb.sd_setImage(with: viewModel.getDataInMovieDetail(indexPath: indexPath).imgURL, placeholderImage: UIImage(named: "placeholder.png"))
        
        cell.likeBtn = {[ unowned self] in
            viewModel.saveMovieToFavorite(indexPath: indexPath)
        }
        cell.likeButton.isHidden = viewModel.isHiddenButtonLike()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
