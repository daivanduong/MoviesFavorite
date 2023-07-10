//
//  MovieViewCell.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import UIKit

class MovieViewCell: UITableViewCell {
    
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var primaryGenre: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    var likeBtn: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    func setupView() {
        imgThumb.layer.cornerRadius = 10
        year.layer.cornerRadius = 10
        price.layer.cornerRadius = 10
        likeButton.layer.cornerRadius = 10
        
    }
    
    func setupButton() {
        if likeButton.titleLabel?.text == "Like" {
            likeButton.setTitle("Liked", for: .normal)
        }
    }
    
    @IBAction func tapOnLike(_ sender: Any) {
        setupButton()
        likeBtn?()
    }
}
