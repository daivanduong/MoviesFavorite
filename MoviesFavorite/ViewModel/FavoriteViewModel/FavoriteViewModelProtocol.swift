//
//  FavoriteViewModelProtocol.swift
//  MoviesFavorite
//
//  Created by Ocean97 on 25/06/2023.
//

import Foundation
import UIKit

protocol FavoriteViewModelProtocol {
    var reloadUI: (() -> ())? { get set }
    func getData()
    func numberOfRowsInSection(section: Int) -> Int
    func getDataInMovie(indexPath: IndexPath) -> (name: String, primaryGenre:String, year: Int, price: Double, imgURL: URL )
    func getDataItemDetail(indexPath: IndexPath) -> Movie
    func deledeRowFortable(table: UITableView,editingStyle: UITableViewCell.EditingStyle ,index: IndexPath)
    func showNotification() -> Bool
}
