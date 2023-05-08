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
    
    var model = DBModel()
    
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
    
    func initDB(){
        model.firestore = Firestore.firestore()
    }
    
    func registration(email: String, password: String, username : String){
        Auth.auth().createUser(withEmail: email, password: password) { [ self] authResult, error in
            
            if let error = error {
                print("error_creating_new_user".localized + "\(error.localizedDescription)")
                error_mes.value =  "error_creating_new_user".localized + "\(error.localizedDescription)"
                return
            }
            
            guard let user = authResult?.user else { return }
            
            let userRef = model.firestore.collection("users").document(user.uid)
            let userData: [String: Any] = ["email": email, "username": username, "password" : password]
            
            userRef.setData(userData) { [self] error in
                if let error = error {
                    print("error_saving_user_info".localized + "\(error.localizedDescription)")
                    error_mes.value =  "error_saving_user_info".localized + "\(error.localizedDescription)"
                    return
                }
                
                
                
            }
        }
        error_mes.value = ""
    }
    
    func signOutCurrentUser() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("error_log_out".localized, signOutError)
        }
    }
}
