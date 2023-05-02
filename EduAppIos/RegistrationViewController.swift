//
//  RegistrationViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/2/23.
//

import Foundation

import UIKit

class RegistrationViewController: UIViewController {
    private let emailTextField = UITextField()
    private let sendCodeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Введите вашу почту"
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        sendCodeButton.setTitle("Отправить код", for: .normal)
        sendCodeButton.setTitleColor(.systemBlue, for: .normal)
        sendCodeButton.addTarget(self, action: #selector(sendCodeButtonTapped), for: .touchUpInside)
        view.addSubview(sendCodeButton)
        sendCodeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            sendCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendCodeButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func sendCodeButtonTapped() {
        // Здесь вы можете реализовать отправку кода на электронную почту пользователя
        print("Отправка кода на адрес: \(emailTextField.text ?? "")")
    }
}
