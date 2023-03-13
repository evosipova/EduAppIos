
//
//  ImageCollectionViewCell.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 11.03.2023.
//

import Foundation

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    var puzzleImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        puzzleImage = UIImageView()
        self.addSubview(puzzleImage)
        puzzleImage.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        puzzleImage.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        puzzleImage.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        puzzleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 9).isActive =  true
        puzzleImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive =  true
        puzzleImage.layer.borderWidth = 0

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        self.frame = puzzleImage.frame
    }

}
