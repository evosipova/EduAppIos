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

    func registration(email: String, password: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self.error_mes.value = error.localizedDescription
            } else {
                guard let userId = result?.user.uid else { return }
                let userData: [String: Any] = [
                    "username": username,
                    "email": email,
                    "avatarName": "user1",
                    "password" : password,
                    "game1Plays": 0,
                    "game2Plays": 0,
                    "game3Plays": 0
                ]

                Firestore.firestore().collection("users").document(userId).setData(userData) { error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        self.error_mes.value = error.localizedDescription
                    } else {
                        self.error_mes.value = ""
                    }
                }
            }
        }
    }


    func signOutCurrentUser() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("error_log_out".localized, signOutError)
        }
    }
}
