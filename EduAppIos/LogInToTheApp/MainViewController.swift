//
//  MainViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/2/23.
//

import Foundation
import UIKit

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
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.cyan.cgColor,
            UIColor.green.cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)

        view.layer.insertSublayer(gradientLayer, at: 0)

        
        let registerButton = UIButton()
               registerButton.setTitle("Регистрация", for: .normal)
               registerButton.setTitleColor(.white, for: .normal)
               registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        

        
        let loginButton = UIButton()
        loginButton.setTitle("Авторизация", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    
        
        let guestModeButton = UIButton()
        guestModeButton.setTitle("Гостевой режим", for: .normal)
        guestModeButton.setTitleColor(.white, for: .normal)
        guestModeButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        let buttonStackView = UIStackView(arrangedSubviews: [registerButton, loginButton, guestModeButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 20
        buttonStackView.distribution = .fillEqually
        
        self.view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            buttonStackView.widthAnchor.constraint(equalToConstant: 200)
        ])
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
        let menuViewController = MenuViewController()
        self.navigationController?.pushViewController(menuViewController, animated: true)
    }
}
