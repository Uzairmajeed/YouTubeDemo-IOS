//
//  HomeCollectionCell.swift
//  YouTube-Demo
//
//  Created by Uzair Majeed on 09/06/24.
//

import UIKit
import Kingfisher

class HomeCollectionCell: UICollectionViewCell {
    @IBOutlet var date: UILabel!
    @IBOutlet var imageview: UIImageView!
    
    @IBOutlet var title: UILabel!
    @IBOutlet var publisher: UILabel!
    
    
    // Method to configure the cell with an Item
        func configure(with item: Item) {
            date.text = item.date
            title.text = item.title
            publisher.text = item.publisher
            
            // Use Kingfisher to load the image
            if let url = URL(string: item.xhd_image) {
                imageview.kf.setImage(with: url)
            }
        }
    
}


