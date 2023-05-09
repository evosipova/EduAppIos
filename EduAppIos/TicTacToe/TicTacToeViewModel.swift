//
//  TicTacToeViewModel.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 03.05.2023.
//

import Foundation
import UIKit


class TicTacToeViewModel {
   var model = TicTacToeModel()

    var game2Plays: Int = 0
    
    func buttonPressed(sender: UIButton!, index: Int){
        if(sender.title(for: .normal) == ""){
            if(model.currentTurn == TicTacToeModel.Turn.X){
                model.buttons[index].value = "X"
                sender.setTitle("X", for: .normal)
                sender.setTitleColor(.clear, for: .normal)
                let img = UIImage(named: "x_symbol.svg")
                let newImg = imageWithImage(image: img!, scaledToSize: CGSize(width: 90, height: 90))
                sender.setImage(newImg, for: .normal)
                sender.contentMode = .center
                sender.imageView?.contentMode = .scaleAspectFit
            
                sender.titleLabel!.font = UIFont(name: "Raleway-Bold", size: 40)
                sender.titleLabel!.font = UIFont.boldSystemFont(ofSize: 60)
                sender.isEnabled = false
                checkWinner()
                model.currentTurn = TicTacToeModel.Turn.O
                model.turnLabel.value = "turn_o".localized(MainViewController.language)
            }
            else if(model.currentTurn == TicTacToeModel.Turn.O){
                model.buttons[index].value = "O"
                sender.setTitle("O", for: .normal)
                sender.setTitleColor(.clear, for: .normal)
                let img = UIImage(named: "o_symbol.svg")
                let newImg = imageWithImage(image: img!, scaledToSize: CGSize(width: 90, height: 90))
                sender.setImage(newImg, for: .normal)
                sender.contentMode = .center
                sender.imageView?.contentMode = .scaleAspectFit
                
                sender.titleLabel!.font = UIFont(name: "Raleway-Bold", size: 40)
                sender.titleLabel!.font = UIFont.boldSystemFont(ofSize: 60)
                sender.isEnabled = false
                checkWinner()
                //print(0)
                model.currentTurn = TicTacToeModel.Turn.X
                model.turnLabel.value = "turn_x".localized(MainViewController.language)
                
            }
            
        }
        
        model.boardIsFull = isBoardFull()
        
    }
    
    func checkWinner(){
        var cur = "O"
        if (model.currentTurn == TicTacToeModel.Turn.X){
            cur = "X"
        }
        var i = 0
        while(i < 7){
            
            if(model.buttons[i].value == cur && model.buttons[i+1].value == cur && model.buttons[i+2].value == cur){
                model.winner.value = cur
                return;
            }
            i += 3
        }
        i=0
        while(i < 3){
            if(model.buttons[i].value == cur && model.buttons[i+3].value  == cur && model.buttons[i+6].value  == cur){
                model.winner.value = cur
                return;
            }
            i += 1
        }
        
        if(model.buttons[0].value == cur && model.buttons[4].value  == cur && model.buttons[8].value == cur){
            model.winner.value = cur
            return;
        }
        
        if(model.buttons[2].value  == cur && model.buttons[4].value  == cur && model.buttons[6].value  == cur){
            model.winner.value = cur
            return;
        }
        return;
    }
    
    func isBoardFull() -> Bool{
        for button in model.buttons {
            if(button.value == ""){
                return false
            }
        }
        return true
        
    }
    
    func clearBoard(){
        for button in model.buttons {
            button.value = ""
        }
        if(model.firstTurn == TicTacToeModel.Turn.X){
            model.firstTurn = TicTacToeModel.Turn.O
            model.turnLabel.value = "turn_o".localized(MainViewController.language)
        }
        else{
            model.firstTurn = TicTacToeModel.Turn.X
            model.turnLabel.value = "turn_x".localized(MainViewController.language)
        }
        model.currentTurn = model.firstTurn
        model.boardIsFull = false
        model.winner.value = ""
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRectMake(6, 3, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return newImage
    }
}

