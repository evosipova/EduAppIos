//
//  TicTacToeViewController.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 08.03.2023.
//

import Foundation

import UIKit

class TicTacToeViewController: UIViewController {
    var viewRect = UILabel()
    var stackView = UIStackView()
    var turnLabel: UILabel! = {
        var turnLabel = UILabel()
        turnLabel.text = "х"
        turnLabel.font = UIFont(name: "Raleway-Bold", size: 30)
        turnLabel.font = UIFont.boldSystemFont(ofSize: 30)
        turnLabel.translatesAutoresizingMaskIntoConstraints = false
        return turnLabel
    }()
    
    var buttons : [UIButton] = []
    
    @objc func boardTapAction( _ sender: UIButton!){
        if(turnLabel.text == "x"){
            
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
        view.addSubview(turnLabel)
        turnLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.06).isActive = true
        turnLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/2).isActive = true
        
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
        
        
        var parent = self.view!
        
        parent.addSubview(viewRect)
        
        viewRect.translatesAutoresizingMaskIntoConstraints = false
        
        
        viewRect.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        viewRect.heightAnchor.constraint(equalToConstant: view.frame.height*0.7).isActive = true
        
        viewRect.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        
        viewRect.topAnchor.constraint(equalTo: parent.topAnchor, constant: view.frame.height*0.15).isActive = true
        
        viewRect.layer.cornerRadius = view.frame.width/9
        
        viewRect.clipsToBounds = true
        
//        viewRect.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    
    private func createButton()->UIButton{
        let button = UIButton()
        button.layer.backgroundColor = UIColor(red: 0.897, green: 0.897, blue: 0.897, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
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
        
//        stackView.frame = CGRect(x: 0, y: 0, width: viewRect.frame.width*0.8, height: viewRect.frame.width*0.8)
//
//        viewRect.addSubview(stackView)
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        stackView.widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.8).isActive = true
//
//        stackView.heightAnchor.constraint(equalToConstant: viewRect.frame.width*0.8).isActive = true
//
//        stackView.leadingAnchor.constraint(equalTo: viewRect.leadingAnchor, constant: viewRect.frame.width*0.1).isActive = true
//
//        stackView.topAnchor.constraint(equalTo: viewRect.topAnchor, constant: (viewRect.frame.height-viewRect.frame.width*0.8)/2).isActive = true
//        stackView.distribution = .fillEqually
//        stackView.axis = .horizontal
//        stackView.spacing = 5
//        let verticalFirstStackView = createVstack()
//        let verticalSecondStackView = createVstack()
//        let verticalThirdStackView = createVstack()
//        for i in 0...8 {
//            buttons.append(createButton())
//            view.addSubview(buttons[i])
//            if(i < 3){
//                verticalFirstStackView.addArrangedSubview(buttons[i])
//            }
//            if(i >= 3 && i < 6){
//                verticalSecondStackView.addArrangedSubview(buttons[i])
//            }
//            if(i >= 6){
//                verticalThirdStackView.addArrangedSubview(buttons[i])
//            }
//        }
        
//        stackView.addArrangedSubview(verticalFirstStackView)
//        stackView.addArrangedSubview(verticalSecondStackView)
//        stackView.addArrangedSubview(verticalThirdStackView)
        for button in buttons {
            button.addTarget(self ,action: #selector(boardTapAction), for: .touchUpInside)
            
        }
        
    }
}
