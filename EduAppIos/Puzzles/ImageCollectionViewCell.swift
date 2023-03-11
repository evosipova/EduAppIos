//
//  ImageCollectionViewCell.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 11.03.2023.
//

import Foundation

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var puzzleImage: UIImageView!
    
    override func awakeFromNib() {
        self.frame = puzzleImage.frame
    }
    
}
