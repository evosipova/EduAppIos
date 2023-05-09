//
//  MenuViewController.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 07.03.2023.
//

import Foundation
import UIKit
import Firebase


class MenuViewController: UIViewController {
    struct Model {
        var games: String
        var puzzle: String
        var tictactoe: String
        var memory: String
    }
    
    var viewRect = UILabel()
    var buttonPuzzles = UIButton()
    var buttonTicTac = UIButton()
    var buttonMemory = UIButton()

    var labelPuzzlesPlayed = UILabel()
    var labelTicTacPlayed = UILabel()
    var labelMemoryPlayed = UILabel()


    var buttonProfile = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDataFromFirestore()
        
    }
    
    
    
    func configure(with model: Model) {
        buttonPuzzles.setTitle(model.puzzle, for: .normal)
        buttonTicTac.setTitle(model.tictactoe, for: .normal)
        buttonMemory.setTitle(model.memory, for: .normal)
        
    }
    
    @objc
    private func buttonProfilePressed(){
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    
    @objc
    private func buttonTicTacPressed(){
        self.navigationController?.pushViewController(TicTacToeViewController(), animated: true)
    }
    
    @objc
    private func buttonMemoryPressed(){
        self.navigationController?.pushViewController(MemoryViewController(), animated: true)
    }
    
    @objc
    func buttonPuzzlesPressed(){
        self.navigationController?.pushViewController(PuzzleViewController(), animated: true)
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
        self.navigationItem.hidesBackButton = true
        
        setupRectangle()
        setupButtons()
        setupUser()
        setupProfileButton()

        setupLabels()
        
        
    }
    
    private func setupProfileButton() {
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let imageUser = UIImage(systemName: "person", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        buttonProfile.setImage(imageUser, for: .normal)
        
        
        view.addSubview(buttonProfile)
        buttonProfile.backgroundColor = .clear
        buttonProfile.translatesAutoresizingMaskIntoConstraints = false
        buttonProfile.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width / 20).isActive = true
        buttonProfile.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        buttonProfile.widthAnchor.constraint(equalToConstant: view.frame.width * 0.13).isActive = true
        buttonProfile.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        
        buttonProfile.addTarget(self, action: #selector(buttonProfilePressed), for: .touchUpInside)
    }
    
    private func setupUser() {
        
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.9)
        label.textColor = .white
        label.font = UIFont(name: "Raleway-Bold", size: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "games".localized(MainViewController.language)
        view.addSubview(label)
        label.pin(to: view, [.top: view.frame.height * 0.09, .left: view.frame.width / 20])
        
        
    }
    
    
    private func setupRectangle() {
        
        viewRect.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.7)
        
        viewRect.backgroundColor = .white
        
        viewRect.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        let parent = self.view!
        
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
        let parent = self.view!
        parent.addSubview(buttonPuzzles)
        buttonPuzzles.translatesAutoresizingMaskIntoConstraints = false
        buttonPuzzles.widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.9).isActive = true
        buttonPuzzles.heightAnchor.constraint(equalToConstant: viewRect.frame.height*0.2).isActive = true
        buttonPuzzles.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: viewRect.frame.width*0.05).isActive = true
        buttonPuzzles.topAnchor.constraint(equalTo: viewRect.topAnchor, constant: viewRect.frame.height*0.1).isActive = true
        
        
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let image = UIImage(systemName: "arrowtriangle.right.fill",withConfiguration: config)?.withTintColor(.black
                                                                                                             , renderingMode: .alwaysOriginal)
        buttonPuzzles.setImage(image, for: .normal)
        buttonPuzzles.imageEdgeInsets.left = -buttonPuzzles.frame.width*0.75
        
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: buttonPuzzles.frame.width, height: buttonPuzzles.frame.height*0.9)
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont(name: "Raleway-Bold", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "puzzle".localized(MainViewController.language)
        buttonPuzzles.addSubview(label)
        label.pinCenter(to: buttonPuzzles)
        
        let imagePuzzle = UIImage(named: "puzzle_icon.svg")!
        let newImage: UIImage = imageWithImage(image: imagePuzzle, scaledToSize: CGSize(width: buttonPuzzles.frame.height/2, height: buttonPuzzles.frame.height/2))
        
        let imagePuzzleView = UIImageView(image: newImage)
        
        buttonPuzzles.addSubview(imagePuzzleView)
        imagePuzzleView.pin(to: buttonPuzzles, [.top: buttonPuzzles.frame.height/3.2, .right: viewRect.frame.width/40])
        buttonPuzzles.addTarget(self, action: #selector(buttonPuzzlesPressed), for: .touchUpInside)
        
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return newImage
    }


    private let labelTicTac = UILabel()

    private func setupButtonTicTac() {
        buttonTicTac.frame = CGRect(x: 0, y: 0, width: viewRect.frame.width*0.95, height: viewRect.frame.height*0.2)
        buttonTicTac.backgroundColor = .white
        buttonTicTac.layer.cornerRadius = 20
        buttonTicTac.layer.borderColor = UIColor(red: 0.554, green: 0.599, blue: 1, alpha: 1).cgColor
        buttonTicTac.layer.borderWidth = 2
        let parent = self.view!
        parent.addSubview(buttonTicTac)
        buttonTicTac.translatesAutoresizingMaskIntoConstraints = false
        buttonTicTac.widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.9).isActive = true
        buttonTicTac.heightAnchor.constraint(equalToConstant: viewRect.frame.height*0.2).isActive = true
        buttonTicTac.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: viewRect.frame.width*0.05).isActive = true
        buttonTicTac.topAnchor.constraint(equalTo: viewRect.topAnchor, constant: viewRect.frame.height*0.4).isActive = true
        
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let image = UIImage(systemName: "arrowtriangle.right.fill",withConfiguration: config)?.withTintColor(.black
                                                                                                             , renderingMode: .alwaysOriginal)
        
        buttonTicTac.setImage(image, for: .normal)
        
        buttonTicTac.imageEdgeInsets.left = -buttonTicTac.frame.width*0.75
        
        
        //        let label = UILabel()
        //        label.frame = CGRect(x: 0, y: 0, width: buttonTicTac.frame.width, height: buttonTicTac.frame.height*0.9)
        //        label.backgroundColor = .white
        //        label.textColor = .black
        //        label.font = UIFont(name: "Raleway-Bold", size: 18)
        //        label.font = UIFont.boldSystemFont(ofSize: 18)
        //        label.text = "tic-tac-toe".localized(MenuViewController.language)
        //        buttonTicTac.addSubview(label)
        //        label.pinCenter(to: buttonTicTac)


        labelTicTac.removeFromSuperview()
        labelTicTac.frame = CGRect(x: 0, y: 0, width: buttonTicTac.frame.width, height: buttonTicTac.frame.height*0.9)
        labelTicTac.backgroundColor = .white
        labelTicTac.textColor = .black
        labelTicTac.font = UIFont(name: "Raleway-Bold", size: 18)
        labelTicTac.font = UIFont.boldSystemFont(ofSize: 18)
        labelTicTac.text = "tic-tac-toe".localized(MainViewController.language)
        buttonTicTac.addSubview(labelTicTac)
        labelTicTac.pinCenter(to: buttonTicTac)


        let imageTicTac = UIImage(named: "tictactoe_icon.svg")!
        let newImage: UIImage = imageWithImage(image: imageTicTac, scaledToSize: CGSize(width: buttonTicTac.frame.height/2.5, height: buttonTicTac.frame.height/2.5))
        
        let imageTicTacView = UIImageView(image: newImage)
        
        buttonTicTac.addSubview(imageTicTacView)
        imageTicTacView.pin(to: buttonTicTac, [.top: buttonTicTac.frame.height/2.8, .right: viewRect.frame.width/20])
        
        buttonTicTac.addTarget(self, action: #selector(buttonTicTacPressed), for: .touchUpInside)
        
    }
    
    private func setupButtonMemory() {
        buttonMemory.frame = CGRect(x: 0, y: 0, width: viewRect.frame.width*0.95, height: viewRect.frame.height*0.2)
        buttonMemory.backgroundColor = .white
        buttonMemory.layer.cornerRadius = 20
        buttonMemory.layer.borderColor = UIColor(red: 0.554, green: 0.599, blue: 1, alpha: 1).cgColor
        buttonMemory.layer.borderWidth = 2
        let parent = self.view!
        parent.addSubview(buttonMemory)
        buttonMemory.translatesAutoresizingMaskIntoConstraints = false
        buttonMemory.widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.9).isActive = true
        buttonMemory.heightAnchor.constraint(equalToConstant: viewRect.frame.height*0.2).isActive = true
        buttonMemory.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: viewRect.frame.width*0.05).isActive = true
        buttonMemory.topAnchor.constraint(equalTo: viewRect.topAnchor, constant: viewRect.frame.height*0.7).isActive = true
        
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let image = UIImage(systemName: "arrowtriangle.right.fill",withConfiguration: config)?.withTintColor(.black                                          , renderingMode: .alwaysOriginal)
        buttonMemory.setImage(image, for: .normal)
        buttonMemory.imageEdgeInsets.left = -buttonMemory.frame.width*0.75
        
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: buttonMemory.frame.width, height: buttonMemory.frame.height*0.9)
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont(name: "Raleway-Bold", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "memory".localized(MainViewController.language)
        buttonMemory.addSubview(label)
        label.pinCenter(to: buttonMemory)
        
        
        let imageMemory = UIImage(named: "memory_icon.svg")!
        let newImage: UIImage = imageWithImage(image: imageMemory, scaledToSize: CGSize(width: buttonMemory.frame.height/1.8, height: buttonMemory.frame.height/1.8))
        
        let imageMemoryView = UIImageView(image: newImage)
        
        buttonMemory.addSubview(imageMemoryView)
        imageMemoryView.pin(to: buttonMemory, [.top: buttonMemory.frame.height/3.4, .right: viewRect.frame.width/30])
        
        buttonMemory.addTarget(self, action: #selector(buttonMemoryPressed), for: .touchUpInside)
        
    }
    
    private func setupButtons() {
        setupButtonPuzzles()
        setupButtonTicTac()
        setupButtonMemory()
        
    }

    func loadDataFromFirestore() {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser

        if let user = user {
            let docRef = db.collection("users").document(user.uid)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()

                    self.labelPuzzlesPlayed.text = "Количество сыгранных игр: \(data?["game1Plays"] ?? 0)"
                    self.labelTicTacPlayed.text = "Количество сыгранных игр: \(data?["game2Plays"] ?? 0)"
                    self.labelMemoryPlayed.text = "Количество сыгранных игр: \(data?["game3Plays"] ?? 0)"
                } else {
                    print("Document does not exist")
                }
            }
        }
    }


    private func setupLabels() {
        setupLabelPuzzlesPlayed()
        setupLabelTicTacPlayed()
        setupLabelMemoryPlayed()
    }

    private func setupLabelPuzzlesPlayed() {
        labelPuzzlesPlayed.textColor = .black
        labelPuzzlesPlayed.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(labelPuzzlesPlayed)
        labelPuzzlesPlayed.translatesAutoresizingMaskIntoConstraints = false
        labelPuzzlesPlayed.topAnchor.constraint(equalTo: buttonPuzzles.bottomAnchor, constant: 8).isActive = true
        labelPuzzlesPlayed.centerXAnchor.constraint(equalTo: buttonPuzzles.centerXAnchor).isActive = true
    }

    private func setupLabelTicTacPlayed() {
        labelTicTacPlayed.textColor = .black
        labelTicTacPlayed.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(labelTicTacPlayed)
        labelTicTacPlayed.translatesAutoresizingMaskIntoConstraints = false
        labelTicTacPlayed.topAnchor.constraint(equalTo: buttonTicTac.bottomAnchor, constant: 8).isActive = true
        labelTicTacPlayed.centerXAnchor.constraint(equalTo: buttonTicTac.centerXAnchor).isActive = true
    }

    private func setupLabelMemoryPlayed() {
        labelMemoryPlayed.textColor = .black
        labelMemoryPlayed.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(labelMemoryPlayed)
        labelMemoryPlayed.translatesAutoresizingMaskIntoConstraints = false
        labelMemoryPlayed.topAnchor.constraint(equalTo: buttonMemory.bottomAnchor, constant: 8).isActive = true
        labelMemoryPlayed.centerXAnchor.constraint(equalTo: buttonMemory.centerXAnchor).isActive = true
    }

    
}
