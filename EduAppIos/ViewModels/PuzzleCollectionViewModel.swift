//
//  PuzzleCollectionViewModel.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 10.05.2023.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class PuzzleCollectionViewModel{
    var model = PuzzleCollectionModel()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model.index < model.puzzle.count {
            return model.puzzle[model.index].unsolvedImages.count
        } else {
            return 0
        }
    }
    
    func updateGame1PlaysInFirestore() {
        guard let user = Auth.auth().currentUser else {
            print("Error updating game1Plays: user not logged in")
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

            guard let oldGame1Plays = userDocument.data()?["game1Plays"] as? Int else {
                let error = NSError(
                    domain: "AppErrorDomain",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Unable to retrieve game1Plays from snapshot \(userDocument)"
                    ]
                )
                errorPointer?.pointee = error
                return nil
            }

            transaction.updateData(["game1Plays": oldGame1Plays + 1], forDocument: userRef)
            return nil
        }) { (_, error) in
            if let error = error {
                print("Error updating game1Plays: \(error.localizedDescription)")
            } else {
                print("game1Plays successfully updated")
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        let image = UIImage(named: model.puzzle[model.index].unsolvedImages[indexPath.item])!
        let newImage = imageWithImage(image: image, scaledToSize: CGSize(width: cell.frame.width, height: cell.frame.height))
        cell.puzzleImage.image = newImage
        
        return cell
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath:IndexPath, collectionView: UICollectionView) {
         
         if let item = coordinator.items.first,
            let sourceIndexPath = item.sourceIndexPath {
             
             collectionView.performBatchUpdates({
                 model.puzzle[model.index].unsolvedImages.swapAt(sourceIndexPath.item, destinationIndexPath.item)
                 collectionView.reloadItems(at: [sourceIndexPath,destinationIndexPath])
             }, completion: nil)
             
             coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
         }
     }
    
    func getItem(indexPath: IndexPath) -> String {
        return self.model.puzzle[model.index].unsolvedImages[indexPath.item]
    }
    
    func getImgView(size: CGSize) -> UIImageView{
        let img = UIImage(named: model.puzzle[model.index].title)!
        let imgView = UIImageView(image: imageWithImage(image: img, scaledToSize: size))
        return imgView
    }
    
    func chechGameEnd() -> Bool {
        return (model.puzzle[model.index].unsolvedImages == model.puzzle[model.index].solvedImages)
    }
    
}
