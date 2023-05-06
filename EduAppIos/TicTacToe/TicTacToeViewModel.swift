//
//  TicTacToeViewModel.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 03.05.2023.
//

import Foundation
import UIKit


class TicTacToeViewModel {
    var turnLabel = Dynamic("")
    var boardIsFull = false
    var winner = Dynamic("")
    
    var buttons  = [Dynamic(""),Dynamic(""),Dynamic(""),Dynamic(""),Dynamic(""),Dynamic(""),Dynamic(""),Dynamic(""),Dynamic("")]
    
    var firstTurn = TicTacToeModel.Turn.X
    var currentTurn = TicTacToeModel.Turn.X
    
    
    func buttonPressed(sender: UIButton!, index: Int){
        if(sender.title(for: .normal) == ""){
            if(currentTurn == TicTacToeModel.Turn.X){
                buttons[index].value = "X"
                sender.setTitle("X", for: .normal)
                sender.setTitleColor(.black, for: .normal)
                sender.titleLabel!.font = UIFont(name: "Raleway-Bold", size: 40)
                sender.titleLabel!.font = UIFont.boldSystemFont(ofSize: 60)
                sender.isEnabled = false
                checkWinner()
                currentTurn = TicTacToeModel.Turn.O
                turnLabel.value = "Очередь: O"
            }
            else if(currentTurn == TicTacToeModel.Turn.O){
                buttons[index].value = "O"
                sender.setTitle("O", for: .normal)
                sender.setTitleColor(.black, for: .normal)
                sender.titleLabel!.font = UIFont(name: "Raleway-Bold", size: 40)
                sender.titleLabel!.font = UIFont.boldSystemFont(ofSize: 60)
                sender.isEnabled = false
                checkWinner()
                //print(0)
                currentTurn = TicTacToeModel.Turn.X
                turnLabel.value = "Очередь: X"
                
            }
            
        }
        
        boardIsFull = isBoardFull()
    }
    
    func checkWinner(){
        var cur = "O"
        if (currentTurn == TicTacToeModel.Turn.X){
            cur = "X"
        }
        var i = 0
        while(i < 7){
            
            if(buttons[i].value == cur && buttons[i+1].value == cur && buttons[i+2].value == cur){
                winner.value = cur
                return;
            }
            i += 3
        }
        i=0
        while(i < 3){
            if(buttons[i].value == cur && buttons[i+3].value  == cur && buttons[i+6].value  == cur){
                winner.value = cur
                return;
            }
            i += 1
        }
        
        if(buttons[0].value == cur && buttons[4].value  == cur && buttons[8].value == cur){
            winner.value = cur
            return;
        }
        
        if(buttons[2].value  == cur && buttons[4].value  == cur && buttons[6].value  == cur){
            winner.value = cur
            return;
        }
        return;
    }
    
    func isBoardFull() -> Bool{
        for button in buttons {
            if(button.value == ""){
                return false
            }
        }
        return true
        
    }
    
    func clearBoard(){
        for button in buttons {
            button.value = ""
        }
        if(firstTurn == TicTacToeModel.Turn.X){
            firstTurn = TicTacToeModel.Turn.O
            turnLabel.value = "Очередь: O"
        }
        else{
            firstTurn = TicTacToeModel.Turn.X
            turnLabel.value = "Очередь: X"
        }
        currentTurn = firstTurn
        boardIsFull = false
        winner.value = ""
    }
    
    
}

