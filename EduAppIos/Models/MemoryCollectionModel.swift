//
//  MemoryViewModel.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/10/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import UIKit


class MemoryColletionModel {

    var viewRect = UILabel()

    var buttons : [UIButton] = []

    var memoryCollectionController = MemoryCollectionViewController()

    var selectedCategoryIndex: Int = -1

}
