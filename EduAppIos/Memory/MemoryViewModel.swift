//
//  MemoryCollectionViewModel.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 08.05.2023.
//

import Foundation
import UIKit
class MemoryCollectionViewModel{
    var model = MemoryCollectionModel()

    func setImages(){
        guard model.selectedCategoryIndex >= 0, model.selectedCategoryIndex < model.categoriesImages.count else { return }
        model.buttonsImages = model.categoriesImages[model.selectedCategoryIndex]
    }
    func setupGame(){
        model.buttonsImages.shuffle()
        var buttonImagesPairs = model.buttonsImages + model.buttonsImages
        buttonImagesPairs.shuffle()

    }
    func buttonTapped(_ sender: UIButton){
        guard sender.tag < model.buttonsImages.count else { return }

    }

    func getImage(_ sender: UIButton) ->UIImage{
        return model.buttonsImages[sender.tag]!
    }
}
