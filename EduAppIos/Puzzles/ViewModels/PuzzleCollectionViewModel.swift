//
//  PuzzleCollectionViewModel.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 10.05.2023.
//

import Foundation
import UIKit

class PuzzleCollectionViewModel{
    var model = PuzzleCollectionModel()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model.index < model.puzzle.count {
            return model.puzzle[model.index].unsolvedImages.count
        } else {
            return 0
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
