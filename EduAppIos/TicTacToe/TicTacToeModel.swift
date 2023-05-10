//
//  TicTacToeModel.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 03.05.2023.
//

import Foundation
struct TicTacToeModel{
    enum Turn{
        case X
        case O
    }
    
    var turnLabel = Dynamic("")
    var boardIsFull = false
    var game2Plays: Int = 0
    var winner = Dynamic("")
    
    var buttons  = [Dynamic(""),Dynamic(""),Dynamic(""),Dynamic(""),Dynamic(""),Dynamic(""),Dynamic(""),Dynamic(""),Dynamic("")]
    
    var firstTurn = Turn.X
    var currentTurn = Turn.X
    
}

