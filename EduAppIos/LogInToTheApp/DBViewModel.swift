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
    
   
    
    var continueButtonIsHidden = Dynamic(true)
    var numberPadIsHidden = Dynamic(true)
    

    func log_in(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [ self] authResult, error in
            if let error = error {
                print("error_log_in".localized(MainViewController.language)+" \(error.localizedDescription)")
                error_mes.value = "error_log_in".localized(MainViewController.language)+" \(error.localizedDescription)"
                return
            }
            guard let _ = authResult?.user else {
                print("error_fetching_user_info".localized(MainViewController.language))
                error_mes.value = "error_fetching_user_info".localized(MainViewController.language)
                return
            }
        }
        error_mes.value = ""
    }

    func initDB(){
        model.firestore = Firestore.firestore()
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    func registration(email: String, username: String, password: String) {
        
        if email.isEmpty || username.isEmpty || password.isEmpty {
                print("hui")
                continueButtonIsHidden.value = false
                   if(password.isEmpty){
                       numberPadIsHidden.value = false
                   }else{
                       numberPadIsHidden.value  = true
                   }
                error_mes.value = "error_complete_all_fields".localized(MainViewController.language)

                   return
               }
        
        if !isValidEmail(email) {
            print("hui2")
            continueButtonIsHidden.value = false
            if(password.isEmpty){
                numberPadIsHidden.value = false
            }else{
                numberPadIsHidden.value = true
            }
            error_mes.value = "error_enter_valid_email".localized(MainViewController.language)
            return
        }
        
        
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
            print("error_log_out".localized(MainViewController.language), signOutError)
        }
    }
}
