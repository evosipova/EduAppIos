//
//  TicTacToeViewController.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 08.03.2023.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

class TicTacToeViewController: UIViewController {
    
    var viewModel = TicTacToeViewModel()
    
    var viewRect = UILabel()
    var stackView = UIStackView()
    
    
    var infoButton: UIButton!
    var rulesView: UIView!
    var rulesLabel: UILabel!
    
    var turnLabel: UILabel! = {
        var turnLabel = UILabel()
        turnLabel.text = "turn_x".localized(MainViewController.language)
        turnLabel.font = UIFont(name: "Raleway-Bold", size: 26)
        turnLabel.font = UIFont.boldSystemFont(ofSize: 26)
        turnLabel.translatesAutoresizingMaskIntoConstraints = false
        return turnLabel
    }()
    
    var label: UILabel! = {
        var label = UILabel()
        label.text = "tic_tac_toe".localized(MainViewController.language)
        label.font = UIFont(name: "Raleway-Bold", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var buttons : [UIButton] = []
    
    var endGameContoller = EndGameViewController()
    var backButton = UIButton()
    
    func bindViewModel(){
        for i in 0...8{
            viewModel.model.buttons[i].bind({_ in self.buttons[i].title(for: .normal)
                
            })
        }
        
        viewModel.model.turnLabel.bind({ (turnLabel) in
            DispatchQueue.main.async {
                self.turnLabel.text = turnLabel
            }
            
        })
    }
    
    @objc func boardTapAction( _ sender: UIButton!){
        addToBoard(sender)
        
    }
    
    
    func win(winner: String) {
        finishGame(result: "winner".localized(MainViewController.language) + winner)
    }
    
    func finishGame(result: String) {
        endGameContoller.resLabel.text = result
        viewModel.clearBoard()
        viewModel.game2Plays += 1
        updateGame2PlaysInFirestore()
        for button in buttons {
            button.setTitle("", for: .normal)
            button.setImage(nil, for: .normal)
            button.isEnabled = true
        }
        self.navigationController?.pushViewController(endGameContoller, animated: true)
    }
    
    
    func updateGame2PlaysInFirestore() {
        guard let user = Auth.auth().currentUser else {
            print("Error updating game2Plays: user not logged in")
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
            
            guard let oldGame2Plays = userDocument.data()?["game2Plays"] as? Int else {
                let error = NSError(
                    domain: "AppErrorDomain",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Unable to retrieve game2Plays from snapshot \(userDocument)"
                    ]
                )
                errorPointer?.pointee = error
                return nil
            }
            
            transaction.updateData(["game2Plays": oldGame2Plays + 1], forDocument: userRef)
            return nil
        }) { (_, error) in
            if let error = error {
                print("Error updating game2Plays: \(error.localizedDescription)")
            } else {
                print("game2Plays successfully updated")
            }
        }
    }
    
    
    func addToBoard(_ sender: UIButton!) {
        viewModel.buttonPressed(sender: sender, index: buttons.firstIndex(of: sender)!)
        if viewModel.model.boardIsFull == true && viewModel.model.winner.value == "" {
            finishGame(result: "tie".localized(MainViewController.language))
        } else if viewModel.model.winner.value != "" {
            win(winner: viewModel.model.winner.value)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
        
        
        view.addSubview(turnLabel)
        turnLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.2).isActive = true
        turnLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/3).isActive = true
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/3.1).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.06).isActive = true
        
        
        
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "arrow.turn.up.left",withConfiguration: config)?.withTintColor(.white
                                                                                                       , renderingMode: .alwaysOriginal)
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        
        bindViewModel()
        
        setupInfoButton()
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
    }
    private func setupRectangle() {
        
        
        viewRect.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.7)
        
        viewRect.backgroundColor = .white
        
        
        viewRect.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        
        let parent = self.view!
        
        parent.addSubview(viewRect)
        
        viewRect.translatesAutoresizingMaskIntoConstraints = false
        
        
        viewRect.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        viewRect.heightAnchor.constraint(equalToConstant: view.frame.height*0.7).isActive = true
        
        viewRect.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        
        viewRect.topAnchor.constraint(equalTo: parent.topAnchor, constant: view.frame.height*0.15).isActive = true
        
        viewRect.layer.cornerRadius = view.frame.width/9
        
        viewRect.clipsToBounds = true
        
    }
    private func setupRulesView() {
        let rulesViewWidth = view.frame.width * 0.75
        let rulesViewHeight = view.frame.height * 0.35
        let rulesViewSize = CGSize(width: rulesViewWidth, height: rulesViewHeight)
        
        rulesView = UIView(frame: CGRect(origin: .zero, size: rulesViewSize))
        rulesView.center = view.center
        rulesView.backgroundColor = .white
        rulesView.layer.cornerRadius = 10
        rulesView.clipsToBounds = true
        rulesView.isHidden = true
        rulesView.layer.borderColor = UIColor.black.cgColor
        rulesView.layer.borderWidth = 1.0
        
        
        
        let rulesLabel = UILabel()
        rulesLabel.font = UIFont(name: "Raleway-Bold", size: 24)
        
        rulesLabel.text = "tic_tac_toe_rules".localized(MainViewController.language)
        rulesLabel.numberOfLines = 0
        rulesLabel.textAlignment = .center
        
        rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        rulesView.addSubview(rulesLabel)
        NSLayoutConstraint.activate([
            rulesLabel.leadingAnchor.constraint(equalTo: rulesView.leadingAnchor, constant: 10),
            rulesLabel.trailingAnchor.constraint(equalTo: rulesView.trailingAnchor, constant: -10),
            rulesLabel.topAnchor.constraint(equalTo: rulesView.topAnchor, constant: 10),
            rulesLabel.bottomAnchor.constraint(equalTo: rulesView.bottomAnchor, constant: -10)
        ])
        
        view.addSubview(rulesView)
    }
    
    @objc private func infoButtonTapped() {
        if rulesView == nil {
            setupRulesView()
        }
        
        rulesView.isHidden = !rulesView.isHidden
    }
    
    private let infoButtonConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)
    
    private func setupInfoButton() {
        infoButton = UIButton(type: .system)
        infoButton.setImage(UIImage(systemName: "questionmark.circle", withConfiguration: infoButtonConfig), for: .normal)
        infoButton.tintColor = .white
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        view.addSubview(infoButton)
        infoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    
    private func createButton()->UIButton{
        let button = UIButton()
        button.layer.backgroundColor = UIColor(red: 0.897, green: 0.897, blue: 0.897, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        view.addSubview(button)
        return button
    }
    
    private func createVstack()->UIStackView{
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 5
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
    }
    
    
    private func setupStackView() {
        var const1: CGFloat =  (viewRect.frame.width*0.2 - 15)/2
        var const2: CGFloat = (viewRect.frame.height-viewRect.frame.width*0.8-15)/2
        for i in 0...8 {
            buttons.append(createButton())
            view.addSubview(buttons[i])
            buttons[i].translatesAutoresizingMaskIntoConstraints = false;
            buttons[i].widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.8/3).isActive = true
            
            buttons[i].heightAnchor.constraint(equalToConstant: viewRect.frame.width*0.8/3).isActive = true
            
            
            buttons[i].leadingAnchor.constraint(equalTo: viewRect.leadingAnchor, constant: const1 ).isActive = true
            
            const1 += 5 + viewRect.frame.width*0.8/3
            buttons[i].topAnchor.constraint(equalTo: viewRect.topAnchor, constant: const2).isActive = true
            if((i+1)%3 == 0){
                const1 = (viewRect.frame.width*0.2 - 15)/2
                const2 += viewRect.frame.width*0.8/3 + 5
            }
        }
        for button in buttons {
            button.addTarget(self ,action: #selector(boardTapAction), for: .touchUpInside)
            button.setTitle("", for: .normal)
            
        }
        
    }
}
