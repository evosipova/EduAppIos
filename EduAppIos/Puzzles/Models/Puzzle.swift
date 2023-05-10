//
//  Puzzle.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 11.03.2023.
//


import Foundation

class Puzzle: Codable {
    var title: String
    var solvedImages: [String]
    var unsolvedImages: [String]
    
    init(title: String, solvedImages: [String]) {
        self.title = title
        self.solvedImages = solvedImages
        self.unsolvedImages = self.solvedImages.shuffled()
    }
}



