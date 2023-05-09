//
//  MainViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/2/23.
//

import Foundation
import UIKit


class MainViewController: UIViewController {
    struct Model {
        var registration: String
        var authorization: String
        var guest: String
    }
    
    var viewModel = DBViewModel()
    private var guestButton: EduGradientButton = EduGradientButton()
    private var registrationButton: EduGradientButton = EduGradientButton()
    private var authorizationButton: EduGradientButton = EduGradientButton()
    
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
    
    private func configure(with model: Model) {
        guestButton.title = model.guest
        registrationButton.configure(with: model.registration)
        authorizationButton.title = model.authorization
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
            registrationButton,
            authorizationButton,
            guestButton
        ]
        
        registrationButton.action = { [weak self] in
            self?.registerButtonTapped()
        }
        
        authorizationButton.action = { [weak self] in
            self?.loginButtonTapped()
        }
        
        guestButton.action = { [weak self] in
            self?.continueButtonTapped()
        }
        
        
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
        
        configure(
            with: Model(
                registration: "registration".localized(),
                authorization: "authorization".localized(),
                guest: "guest".localized()
            )
        )
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
        
        viewModel.signOutCurrentUser()
        let menuViewController = MenuViewController()
        
        let navigation = UINavigationController(rootViewController: menuViewController)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    
}
