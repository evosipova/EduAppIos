//
//  MemoryCollectionModel.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 08.05.2023.
//

import Foundation
import UIKit

class MemoryCollectionModel {
    var selectedCategoryIndex: Int = -1

    let categoriesImages: [[UIImage?]] = [
        [UIImage(named: "apple"), UIImage(named: "banana"), UIImage(named: "carrot"), UIImage(named: "eggplant"), UIImage(named: "orange"), UIImage(named: "peach"), UIImage(named: "pepper"), UIImage(named: "radish"),UIImage(named: "apple"), UIImage(named: "banana"), UIImage(named: "carrot"), UIImage(named: "eggplant"), UIImage(named: "orange"), UIImage(named: "peach"), UIImage(named: "pepper"), UIImage(named: "radish")],

        [UIImage(named: "airplane"), UIImage(named: "bus"), UIImage(named: "excavator"), UIImage(named: "fighterJet"), UIImage(named: "greenCar"), UIImage(named: "redCar"), UIImage(named: "rocket"), UIImage(named: "tractor"), UIImage(named: "airplane"), UIImage(named: "bus"), UIImage(named: "excavator"), UIImage(named: "fighterJet"), UIImage(named: "greenCar"), UIImage(named: "redCar"), UIImage(named: "rocket"), UIImage(named: "tractor")],

        [UIImage(named: "cactus"), UIImage(named: "chamomile"), UIImage(named: "forget-me-not"), UIImage(named: "hyacinth"), UIImage(named: "marigold"), UIImage(named: "sunflower"), UIImage(named: "tulip"), UIImage(named: "lily"), UIImage(named: "cactus"), UIImage(named: "chamomile"), UIImage(named: "forget-me-not"), UIImage(named: "hyacinth"), UIImage(named: "marigold"), UIImage(named: "sunflower"),UIImage(named: "tulip"), UIImage(named: "lily")],

        [UIImage(named: "cat"), UIImage(named: "dog"), UIImage(named: "giraffe"), UIImage(named: "greenFish"),UIImage(named: "hedgehog"), UIImage(named: "lion"), UIImage(named: "mouse"), UIImage(named: "rabbit"), UIImage(named: "cat"), UIImage(named: "dog"), UIImage(named: "giraffe"), UIImage(named: "greenFish"),UIImage(named: "hedgehog"), UIImage(named: "lion"), UIImage(named: "mouse"), UIImage(named: "rabbit")]
    ]
    var buttonsImages: [UIImage?] = []

}
