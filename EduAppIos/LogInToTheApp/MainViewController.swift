//
//  MainViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/2/23.
//

import Foundation
import UIKit
import Firebase

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBackButton()
    }
     
    private func updateBackButton() {
        let backButtonImage = UIImage(systemName: "arrow.turn.up.left")
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupView() {
        
        let image = UIImage(named: "launch")
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        let appNameLabel = UILabel()
        appNameLabel.text = "SmartPlay"
        appNameLabel.textAlignment = .center
        appNameLabel.font = UIFont(name: "Futura Bold", size: 35)
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(appNameLabel)
        NSLayoutConstraint.activate([
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appNameLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 135)
        ])

        let buttons = [
            createGradientButton(title: "регистрация", action: #selector(registerButtonTapped)),
            createGradientButton(title: "авторизация", action: #selector(loginButtonTapped)),
            createGradientButton(title: "гостевой режим", action: #selector(continueButtonTapped))
        ]

        let buttonStackView = UIStackView(arrangedSubviews: buttons)
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 20
        buttonStackView.distribution = .fillEqually

        self.view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 100),
            buttonStackView.widthAnchor.constraint(equalToConstant: 210),
            buttonStackView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }

    private func createGradientButton(title: String, action: Selector) -> UIImageView {
        
        
        let image = UIImage(named: "grad_buttons")
        let containerView = UIImageView(image: image)
        containerView.contentMode =  UIView.ContentMode.scaleAspectFit
        //containerView.layer.cornerRadius = 30
        containerView.isUserInteractionEnabled = true
        
    
//
       
        
        
        //self.view.sendSubviewToBack(containerView)
        
        
//        let containerView = UIView()
//        containerView.layer.cornerRadius = 5
//        containerView.clipsToBounds = true
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: 210, height: 50)
//        gradientLayer.colors = [
//            UIColor.blue.cgColor,
//            UIColor.blue.cgColor,
//            UIColor.purple.cgColor,
//            UIColor.green.cgColor,
//            UIColor.red.cgColor
//        ]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//
//        containerView.layer.addSublayer(gradientLayer)

        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel!.font = UIFont(name: "Raleway-Bold", size: 17)
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: action, for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true

        containerView.addSubview(button)
    
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 2),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2)
        ])
        return containerView
     }


    
    @objc private func registerButtonTapped() {
           let registrationViewController = RegistrationViewController()
           self.navigationController?.pushViewController(registrationViewController, animated: true)
       }

    @objc private func loginButtonTapped() {
           let loginViewController = LoginViewController()
           self.navigationController?.pushViewController(loginViewController, animated: true)
       }

    
    @objc private func continueButtonTapped() {
        
          signOutCurrentUser()
          let menuViewController = MenuViewController()
          self.navigationController?.pushViewController(menuViewController, animated: true)
      }

    private func signOutCurrentUser() {
           do {
               try Auth.auth().signOut()
           } catch let signOutError as NSError {
               print("Ошибка выхода из аккаунта: %@", signOutError)
           }
       }
}
