//
//  MenuViewController.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 07.03.2023.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    var viewRect = UILabel()
    var buttonPuzzles = UIButton()
    var buttonTicTac = UIButton()
    var buttonMemory = UIButton()
    var ticTacController = TicTacToeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc
       private func buttonTicTacPressed(){
          
           self.navigationController?.pushViewController(ticTacController, animated: true)

           let generator = UIImpactFeedbackGenerator(style: .medium)
           generator.impactOccurred()
           
         
       }
    
    private func setupView() {
        self.view.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
        let layer0 = CAGradientLayer()
        layer0.colors = [
            UIColor(red: 0.554, green: 0.599, blue: 1, alpha: 1).cgColor,
            
            UIColor(red: 0.867, green: 0.65, blue: 1, alpha: 1).cgColor,
        ]
        layer0.locations = [0, 1]
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        
        layer0.frame = view.frame
        view.layer.addSublayer(layer0)
        
        setupRectangle()
        setupButtons()
        setupUser()
        
        
    }
    
    private func setupUser(){
        let config2 = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        var imageUser = UIImage(systemName: "person",withConfiguration: config2)?.withTintColor(.white
                                                                                                            , renderingMode: .alwaysOriginal)
        
        var imageUserView = UIImageView(image: imageUser)
        
        view.addSubview(imageUserView)
        imageUserView.pin(to: view, [.top: view.frame.height*0.08, .right: view.frame.width/20])
        var label = UILabel()
        
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.9)
        
        
        
        label.textColor = .white
        
        label.font = UIFont(name: "Raleway-Bold", size: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        
        label.text = "игры"
        
        
        view.addSubview(label)
        label.pin(to: view, [.top: view.frame.height*0.09, .left: view.frame.width/20])
        
        
    }
    private func setupRectangle() {
        
        
        viewRect.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.7)
        
        viewRect.backgroundColor = .white
        
        
        viewRect.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        
        var parent = self.view!
        
        parent.addSubview(viewRect)
        
        viewRect.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        viewRect.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        viewRect.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        viewRect.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        
        viewRect.topAnchor.constraint(equalTo: parent.topAnchor, constant: view.frame.height*0.2).isActive = true
        
        viewRect.layer.cornerRadius = view.frame.width/9
        
        viewRect.clipsToBounds = true
        
        viewRect.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    
    private func setupButtonPuzzles() {
        buttonPuzzles.frame = CGRect(x: 0, y: 0, width: viewRect.frame.width*0.95, height: viewRect.frame.height*0.2)
        buttonPuzzles.backgroundColor = .white
        buttonPuzzles.layer.cornerRadius = 20
        buttonPuzzles.layer.borderColor = UIColor(red: 0.554, green: 0.599, blue: 1, alpha: 1).cgColor
        buttonPuzzles.layer.borderWidth = 2
        var parent = self.view!
        parent.addSubview(buttonPuzzles)
        buttonPuzzles.translatesAutoresizingMaskIntoConstraints = false
        buttonPuzzles.widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.9).isActive = true
        buttonPuzzles.heightAnchor.constraint(equalToConstant: viewRect.frame.height*0.2).isActive = true
        buttonPuzzles.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: viewRect.frame.width*0.05).isActive = true
        buttonPuzzles.topAnchor.constraint(equalTo: viewRect.topAnchor, constant: viewRect.frame.height*0.1).isActive = true
        
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        var image = UIImage(systemName: "arrowtriangle.right.fill",withConfiguration: config)?.withTintColor(.black
                                                                                                             , renderingMode: .alwaysOriginal)
        
        
        
        buttonPuzzles.setImage(image, for: .normal)
        
        buttonPuzzles.imageEdgeInsets.left = -buttonPuzzles.frame.width*0.75
        
        var label = UILabel()
        
        label.frame = CGRect(x: 0, y: 0, width: buttonPuzzles.frame.width, height: buttonPuzzles.frame.height*0.9)
        
        label.backgroundColor = .white
        
        
        label.textColor = .black
        
        label.font = UIFont(name: "Raleway-Bold", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        label.text = "пазлы"
        
        
        buttonPuzzles.addSubview(label)
        label.pinCenter(to: buttonPuzzles)
        
        let config2 = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        var imagePuzzle = UIImage(systemName: "puzzlepiece.fill",withConfiguration: config2)?.withTintColor(UIColor(red: 0.747, green: 0.917, blue: 0.386, alpha: 1)
                                                                                                            , renderingMode: .alwaysOriginal)
        
        var imagePuzzleView = UIImageView(image: imagePuzzle)
        
        buttonPuzzles.addSubview(imagePuzzleView)
        imagePuzzleView.pin(to: buttonPuzzles, [.top: buttonPuzzles.frame.height/2.8, .right: viewRect.frame.width/40])
        
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    private func setupButtonTicTac() {
        buttonTicTac.frame = CGRect(x: 0, y: 0, width: viewRect.frame.width*0.95, height: viewRect.frame.height*0.2)
        buttonTicTac.backgroundColor = .white
        buttonTicTac.layer.cornerRadius = 20
        buttonTicTac.layer.borderColor = UIColor(red: 0.554, green: 0.599, blue: 1, alpha: 1).cgColor
        buttonTicTac.layer.borderWidth = 2
        var parent = self.view!
        parent.addSubview(buttonTicTac)
        buttonTicTac.translatesAutoresizingMaskIntoConstraints = false
        buttonTicTac.widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.9).isActive = true
        buttonTicTac.heightAnchor.constraint(equalToConstant: viewRect.frame.height*0.2).isActive = true
        buttonTicTac.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: viewRect.frame.width*0.05).isActive = true
        buttonTicTac.topAnchor.constraint(equalTo: viewRect.topAnchor, constant: viewRect.frame.height*0.4).isActive = true
        
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        var image = UIImage(systemName: "arrowtriangle.right.fill",withConfiguration: config)?.withTintColor(.black
                                                                                                             , renderingMode: .alwaysOriginal)
        
        
        
        buttonTicTac.setImage(image, for: .normal)
        
        buttonTicTac.imageEdgeInsets.left = -buttonTicTac.frame.width*0.75
        
        var label = UILabel()
        
        label.frame = CGRect(x: 0, y: 0, width: buttonTicTac.frame.width, height: buttonTicTac.frame.height*0.9)
        
        label.backgroundColor = .white
        
        
        label.textColor = .black
        
        label.font = UIFont(name: "Raleway-Bold", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        label.text = "крестики нолики"
        
        
        buttonTicTac.addSubview(label)
        label.pinCenter(to: buttonTicTac)
        
        
        var imageTicTac = UIImage(named: "tictac.png")!
        var newImage: UIImage = imageWithImage(image: imageTicTac, scaledToSize: CGSize(width: buttonTicTac.frame.height/3, height: buttonTicTac.frame.height/3))
        
        
//        var imagePuzzle = UIImage(named: "tictac.png",withConfiguration: config2)?.withTintColor(UIColor(red: 0.747, green: 0.917, blue: 0.386, alpha: 1)
//                                                                                                            , renderingMode: .alwaysOriginal)
        
        var imagePuzzleView = UIImageView(image: newImage)
        
        buttonTicTac.addSubview(imagePuzzleView)
        imagePuzzleView.pin(to: buttonTicTac, [.top: buttonTicTac.frame.height/2.8, .right: viewRect.frame.width/20])
        
        buttonTicTac.addTarget(self, action: #selector(buttonTicTacPressed), for: .touchUpInside)
        
    }
    
    private func setupButtonMemory() {
        buttonMemory.frame = CGRect(x: 0, y: 0, width: viewRect.frame.width*0.95, height: viewRect.frame.height*0.2)
        buttonMemory.backgroundColor = .white
        buttonMemory.layer.cornerRadius = 20
        buttonMemory.layer.borderColor = UIColor(red: 0.554, green: 0.599, blue: 1, alpha: 1).cgColor
        buttonMemory.layer.borderWidth = 2
        var parent = self.view!
        parent.addSubview(buttonMemory)
        buttonMemory.translatesAutoresizingMaskIntoConstraints = false
        buttonMemory.widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.9).isActive = true
        buttonMemory.heightAnchor.constraint(equalToConstant: viewRect.frame.height*0.2).isActive = true
        buttonMemory.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: viewRect.frame.width*0.05).isActive = true
        buttonMemory.topAnchor.constraint(equalTo: viewRect.topAnchor, constant: viewRect.frame.height*0.7).isActive = true
        
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        var image = UIImage(systemName: "arrowtriangle.right.fill",withConfiguration: config)?.withTintColor(.black
                                                                                                             , renderingMode: .alwaysOriginal)
        
        
        
        buttonMemory.setImage(image, for: .normal)
        
        buttonMemory.imageEdgeInsets.left = -buttonMemory.frame.width*0.75
        
        var label = UILabel()
        
        label.frame = CGRect(x: 0, y: 0, width: buttonMemory.frame.width, height: buttonMemory.frame.height*0.9)
        
        label.backgroundColor = .white
        
        
        label.textColor = .black
        
        label.font = UIFont(name: "Raleway-Bold", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        label.text = "мемори"
        
        
        buttonMemory.addSubview(label)
        label.pinCenter(to: buttonMemory)
        
        
        var imageMemory = UIImage(named: "memoryColor.png")!
        var newImage: UIImage = imageWithImage(image: imageMemory, scaledToSize: CGSize(width: buttonMemory.frame.height/2.2, height: buttonMemory.frame.height/2.2))
        
        
//        var imagePuzzle = UIImage(named: "tictac.png",withConfiguration: config2)?.withTintColor(UIColor(red: 0.747, green: 0.917, blue: 0.386, alpha: 1)
//                                                                                                            , renderingMode: .alwaysOriginal)
        
        var imageMemoryView = UIImageView(image: newImage)
        
        buttonMemory.addSubview(imageMemoryView)
        imageMemoryView.pin(to: buttonMemory, [.top: buttonMemory.frame.height/3.4, .right: viewRect.frame.width/20])
        
    }
    
    private func setupButtons() {
        setupButtonPuzzles()
        setupButtonTicTac()
        setupButtonMemory()
        
    }
    
    
    
}

