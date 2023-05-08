//
//  DBViewModel.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 08.05.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DBViewModel {
    
    var error_mes = Dynamic("")
    
    func log_in(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [ self] authResult, error in
            if let error = error {
                print("error_log_in".localized+" \(error.localizedDescription)")
                error_mes.value = "error_log_in".localized+" \(error.localizedDescription)"
                return
            }
            guard let _ = authResult?.user else {
                print("error_fetching_user_info".localized)
                error_mes.value = "error_fetching_user_info".localized
                return
            }
        }
        error_mes.value = ""
    }
}
