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

    struct User {
        let username: String
        let email: String
        let avatarName: String
    }

    var model = DBModel()

    func log_in(email: String, password: String) {

          if email.isEmpty || password.isEmpty {
              model.continueButtonIsHidden.value = false
              if password.isEmpty {
                  model.numberPadIsHidden.value = false
              } else {
                  model.numberPadIsHidden.value = true
              }
              model.error_mes.value = "error_complete_all_fields".localized(MainViewController.language)
              return
          }


          if !isValidEmail(email) {
              model.continueButtonIsHidden.value = false
              if password.isEmpty {
                  model.numberPadIsHidden.value = false
              } else {
                  model.numberPadIsHidden.value = true
              }
              model.error_mes.value = "error_enter_valid_email".localized(MainViewController.language)
              return
          }


        Auth.auth().signIn(withEmail: email, password: password) { [self] authResult, error in
                   if let error = error {
                       let errorMessage: String
                       switch AuthErrorCode(rawValue: error._code) {
                       case .wrongPassword:
                           errorMessage = "error_wrong_password".localized(MainViewController.language)
                       case .userNotFound:
                           errorMessage = "error_user_not_found".localized(MainViewController.language)
                       default:
                           errorMessage = "error_fetching_user_info".localized(MainViewController.language)
                       }
                       model.error_mes.value = errorMessage
                   } else {
                       model.error_mes.value = ""
                   }
               }

      }

      func initDB(){
          model.firestore = Firestore.firestore()
      }

      func isValidEmail(_ email: String) -> Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
          let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailPredicate.evaluate(with: email)
      }


      func registration(email: String, username: String, password: String) {

          if email.isEmpty || username.isEmpty || password.isEmpty {
              model.continueButtonIsHidden.value = false
              if(password.isEmpty){
                  model.numberPadIsHidden.value = false
              }else{
                  model.numberPadIsHidden.value  = true
              }
              model.error_mes.value = "error_complete_all_fields".localized(MainViewController.language)

              return
          }

          if !isValidEmail(email) {
              model.continueButtonIsHidden.value = false
              if(password.isEmpty){
                  model.numberPadIsHidden.value = false
              }else{
                  model.numberPadIsHidden.value = true
              }
              model.error_mes.value = "error_enter_valid_email".localized(MainViewController.language)
              return
          }


          Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
              if let error = error {
                  print("Error: \(error.localizedDescription)")
                  self.model.error_mes.value = error.localizedDescription
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
                          self.model.error_mes.value = error.localizedDescription
                      } else {
                          self.model.error_mes.value = ""
                      }
                  }
              }
          }
      }

    func isNotAutrorised() ->Bool{
        var auth = false
        let user = Auth.auth().currentUser
        if user == nil {
            auth = true
        }
        return auth
    }

    func signOutCurrentUser() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("error_log_out".localized(MainViewController.language), signOutError)
        }
    }

    func updateAvatarName(newAvatarName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else { return }
        let userRef = Firestore.firestore().collection("users").document(user.uid)

        userRef.updateData(["avatarName": newAvatarName]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            let defaultUser = User(username: "", email: "", avatarName: "user1")
            completion(.success(defaultUser))
            return
        }

        let userRef = Firestore.firestore().collection("users").document(user.uid)

        userRef.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                if let data = document.data() {
                    let fetchedUser = User(username: data["username"] as? String ?? "",
                                           email: data["email"] as? String ?? "",
                                           avatarName: data["avatarName"] as? String ?? "user1")
                    completion(.success(fetchedUser))
                }
            }
        }
    }


    
    func loadDataFromFirestore(completion: @escaping (_ game1Plays: Int, _ game2Plays: Int, _ game3Plays: Int) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            print("No current user")
            return
        }

        let userRef = Firestore.firestore().collection("users").document(currentUser.uid)

        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let game1Plays = data?["game1Plays"] as? Int ?? 0
                let game2Plays = data?["game2Plays"] as? Int ?? 0
                let game3Plays = data?["game3Plays"] as? Int ?? 0

                completion(game1Plays, game2Plays, game3Plays)
            } else {
                print("Document does not exist")
            }
        }
    }


}

