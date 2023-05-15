//
//  MemoryViewModel.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/10/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class MemoryViewModel {
    func updateGame3PlaysInFirestore() {
        guard let user = Auth.auth().currentUser else {
            print("Error updating game3Plays: user not logged in")
            return
        }

        let userRef = Firestore.firestore().collection("users").document(user.uid)

        Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
            let userDocument: DocumentSnapshot
            do {
                try userDocument = transaction.getDocument(userRef)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }

            guard let oldGame3Plays = userDocument.data()?["game3Plays"] as? Int else {
                let error = NSError(
                    domain: "AppErrorDomain",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Unable to retrieve game3Plays from snapshot \(userDocument)"
                    ]
                )
                errorPointer?.pointee = error
                return nil
            }

            transaction.updateData(["game3Plays": oldGame3Plays + 1], forDocument: userRef)
            return nil
        }) { (_, error) in
            if let error = error {
                print("Error updating game3Plays: \(error.localizedDescription)")
            } else {
                print("game3Plays successfully updated")
            }
        }
    }

}
