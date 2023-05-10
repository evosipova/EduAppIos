//
//  PuzzleCollectionModel.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 10.05.2023.
//

import Foundation

class PuzzleCollectionModel{
    
    var puzzle = [Puzzle(title: "desert.svg", solvedImages: ["desert1.svg","desert2.svg","desert3.svg","desert4.svg","desert5.svg","desert6.svg","desert7.svg","desert8.svg","desert9.svg"]),Puzzle(title: "bunny.svg", solvedImages: ["bunny1.svg","bunny2.svg","bunny3.svg","bunny4.svg","bunny5.svg","bunny6.svg","bunny7.svg","bunny8.svg","bunny9.svg"]),Puzzle(title: "fish.svg", solvedImages: ["fish1.svg","fish2.svg","fish3.svg","fish4.svg","fish5.svg","fish6.svg","fish7.svg","fish8.svg","fish9.svg"]),Puzzle(title: "rose.svg", solvedImages: ["rose1.svg","rose2.svg","rose3.svg","rose4.svg","rose5.svg","rose6.svg","rose7.svg","rose8.svg","rose9.svg"])]
    
    var index: Int = 0
    
    var gameTimer: Timer?
}
