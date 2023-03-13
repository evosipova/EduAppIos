//
//  MemoryViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 3/13/23.
//

import Foundation
import UIKit

class MemoryViewController: UIViewController {
    
    
    var viewRect = UILabel()
    var stackView = UIStackView()
    
    
    var label: UILabel! = {
        let label = UILabel()
        label.text = "мемори"
        label.font = UIFont(name: "Raleway-Bold", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var buttons : [UIButton] = []
    
    var buttonsImages = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8")]
    var selectedButtons: [UIButton] = []
    
    var endGameContoller = EndGameViewController()
    var backButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
        setupGame()
        
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.06).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "arrow.turn.up.left",withConfiguration: config)?.withTintColor(.white
                                                                                                       , renderingMode: .alwaysOriginal)
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        
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
    
    
    private func setupGame() {
           var buttonImagesPairs = buttonsImages + buttonsImages
           buttonImagesPairs.shuffle()
           for (index, button) in buttons.enumerated() {
               button.tag = index
               button.setImage(buttonImagesPairs[index], for: .normal)
               button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
           }
       }
       

    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard !selectedButtons.contains(sender) else { return }

        if selectedButtons.count < 2 {
            // Toggle the button image between front and back
            let image = selectedButtons.count == 0 ? buttonsImages[sender.tag] : nil
            sender.setImage(image, for: .normal)
            selectedButtons.append(sender)

            if selectedButtons.count == 2 {
                view.isUserInteractionEnabled = false

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    guard let self = self else { return }

                    if self.selectedButtons[0].currentImage == self.selectedButtons[1].currentImage {
                        self.selectedButtons[0].isEnabled = false
                        self.selectedButtons[1].isEnabled = false
                    } else {
                        // Flip the buttons back over if they don't match
                        self.selectedButtons[0].setImage(nil, for: .normal)
                        self.selectedButtons[1].setImage(nil, for: .normal)
                    }

                    self.selectedButtons.removeAll()
                    self.view.isUserInteractionEnabled = true
                }
            }
        }
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
    }
    
    private func createButton()->UIButton{
        let button = UIButton()
        button.layer.backgroundColor = UIColor(red: 0.897, green: 0.897, blue: 0.897, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }
    
    
    
    private func setupStackView() {
        let buttonCount = 16 // Изменили количество кнопок на 16
        var const1: CGFloat =  (viewRect.frame.width*0.2 - 15)/2
        var const2: CGFloat = (viewRect.frame.height-viewRect.frame.width*0.8-15)/2
        for i in 0..<buttonCount {
            buttons.append(createButton())
            view.addSubview(buttons[i])
            buttons[i].translatesAutoresizingMaskIntoConstraints = false
            buttons[i].widthAnchor.constraint(equalToConstant: viewRect.frame.width*0.8/4).isActive = true
            buttons[i].heightAnchor.constraint(equalToConstant: viewRect.frame.width*0.8/4).isActive = true
            
            buttons[i].leadingAnchor.constraint(equalTo: viewRect.leadingAnchor, constant: const1 ).isActive = true
            const1 += 5 + viewRect.frame.width*0.8/4
            
            buttons[i].topAnchor.constraint(equalTo: viewRect.topAnchor, constant: const2).isActive = true
            if((i+1)%4 == 0){
                const1 = (viewRect.frame.width*0.2 - 15)/2
                const2 += viewRect.frame.width*0.8/4 + 5
            }
        }
    }
}