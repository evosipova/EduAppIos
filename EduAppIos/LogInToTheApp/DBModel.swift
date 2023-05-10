//
//  DBModel.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 08.05.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase

class DBModel{
    var firestore: Firestore!
    var error_mes = Dynamic("")
    
    var continueButtonIsHidden = Dynamic(true)
    var numberPadIsHidden = Dynamic(true)
    
}
