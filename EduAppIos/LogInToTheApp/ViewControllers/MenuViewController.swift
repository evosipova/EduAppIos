//
//  MenuViewController.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 07.03.2023.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase


class MenuViewController: UIViewController {
    var viewModel = DBViewModel()
    struct Model {
        var games: String
        var puzzle: String
        var tictactoe: String
        var memory: String
    }

    var viewRect = UILabel()
    var buttonPuzzles:EduMenuButton = EduMenuButton()
    var buttonTicTac:EduMenuButton = EduMenuButton()
    var buttonMemory:EduMenuButton = EduMenuButton()

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
        let parent = self.view!
        parent.addSubview(buttonPuzzles)
        buttonPuzzles.widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.9).isActive = true
        buttonPuzzles.heightAnchor.constraint(equalToConstant: viewRect.frame.height*0.2).isActive = true
        buttonPuzzles.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: viewRect.frame.width*0.05).isActive = true
        buttonPuzzles.topAnchor.constraint(equalTo: viewRect.topAnchor, constant: viewRect.frame.height*0.1).isActive = true

        var isCentered = viewModel.isNotAutrorised()

        let imagePuzzle = UIImage(named: "puzzle_icon.svg")!
        let newImage: UIImage = imageWithImage(image: imagePuzzle, scaledToSize: CGSize(width: buttonPuzzles.frame.height/2, height: buttonPuzzles.frame.height/2))

        buttonPuzzles.configure(gameImage: newImage, isPinnedCenter: isCentered, name: "puzzle".localized(MainViewController.language))

        buttonPuzzles.addTarget(self, action: #selector(buttonPuzzlesPressed), for: .touchUpInside)

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
        let parent = self.view!
        parent.addSubview(buttonTicTac)
        buttonTicTac.translatesAutoresizingMaskIntoConstraints = false
        buttonTicTac.widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.9).isActive = true
        buttonTicTac.heightAnchor.constraint(equalToConstant: viewRect.frame.height*0.2).isActive = true
        buttonTicTac.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: viewRect.frame.width*0.05).isActive = true
        buttonTicTac.topAnchor.constraint(equalTo: viewRect.topAnchor, constant: viewRect.frame.height*0.4).isActive = true

        var isCentered = viewModel.isNotAutrorised()


        let imageTicTac = UIImage(named: "tictactoe_icon.svg")!
        let newImage: UIImage = imageWithImage(image: imageTicTac, scaledToSize: CGSize(width: buttonTicTac.frame.height/2.5, height: buttonTicTac.frame.height/2.5))

        buttonTicTac.configure(gameImage: newImage, isPinnedCenter: isCentered, name: "tic-tac-toe".localized(MainViewController.language))
        buttonTicTac.addTarget(self, action: #selector(buttonTicTacPressed), for: .touchUpInside)

    }

    private func setupButtonMemory() {
        buttonMemory.frame = CGRect(x: 0, y: 0, width: viewRect.frame.width*0.95, height: viewRect.frame.height*0.2)

        let parent = self.view!
        parent.addSubview(buttonMemory)
        buttonMemory.translatesAutoresizingMaskIntoConstraints = false
        buttonMemory.widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.9).isActive = true
        buttonMemory.heightAnchor.constraint(equalToConstant: viewRect.frame.height*0.2).isActive = true
        buttonMemory.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: viewRect.frame.width*0.05).isActive = true
        buttonMemory.topAnchor.constraint(equalTo: viewRect.topAnchor, constant: viewRect.frame.height*0.7).isActive = true

        var isCentered = viewModel.isNotAutrorised()

        let imageMemory = UIImage(named: "memory_icon.svg")!
        let newImage: UIImage = imageWithImage(image: imageMemory, scaledToSize: CGSize(width: buttonMemory.frame.height/1.8, height: buttonMemory.frame.height/1.8))
        buttonMemory.configure(gameImage: newImage, isPinnedCenter: isCentered, name: "memory".localized(MainViewController.language))

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

                    self.labelPuzzlesPlayed.text = "game_amount".localized(MainViewController.language) + " \(data?["game1Plays"] ?? 0)"
                    self.labelTicTacPlayed.text = "game_amount".localized(MainViewController.language) + " \(data?["game2Plays"] ?? 0)"
                    self.labelMemoryPlayed.text = "game_amount".localized(MainViewController.language) + " \(data?["game3Plays"] ?? 0)"
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
        labelPuzzlesPlayed.font = UIFont(name: "Raleway-Bold", size: 15)
        labelPuzzlesPlayed.font = UIFont.boldSystemFont(ofSize: 15)
        buttonPuzzles.addSubview(labelPuzzlesPlayed)
        labelPuzzlesPlayed.translatesAutoresizingMaskIntoConstraints = false
        labelPuzzlesPlayed.pin(to: buttonPuzzles, [.top : buttonPuzzles.frame.height/2,.left : buttonPuzzles.frame.width*0.25])

    }

    private func setupLabelTicTacPlayed() {
        labelTicTacPlayed.textColor = .black
        labelTicTacPlayed.font = UIFont(name: "Raleway-Bold", size: 15)
        labelTicTacPlayed.font = UIFont.boldSystemFont(ofSize: 15)
        buttonTicTac.addSubview(labelTicTacPlayed)
        labelTicTacPlayed.translatesAutoresizingMaskIntoConstraints = false
        labelTicTacPlayed.pin(to: buttonTicTac, [.top : buttonTicTac.frame.height/2,.left : buttonTicTac.frame.width*0.25])
    }

    private func setupLabelMemoryPlayed() {
        labelMemoryPlayed.textColor = .black
        labelMemoryPlayed.font = UIFont(name: "Raleway-Bold", size: 15)
        labelMemoryPlayed.font = UIFont.boldSystemFont(ofSize: 15)
        buttonMemory.addSubview(labelMemoryPlayed)
        labelMemoryPlayed.translatesAutoresizingMaskIntoConstraints = false
        labelMemoryPlayed.pin(to: buttonMemory, [.top : buttonMemory.frame.height/2,.left : buttonMemory.frame.width*0.25])
    }


}
