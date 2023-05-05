//
//  LoginViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/5/23.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let errorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white

        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Введите вашу почту"
        emailTextField.autocapitalizationType = .none
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Введите ваш пароль"
        passwordTextField.autocapitalizationType = .none
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        errorLabel.textColor = .red
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),

            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }

    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print("Ошибка при входе в систему: \(error.localizedDescription)")
                self?.showError(message: "Ошибка при входе в систему: \(error.localizedDescription)")
                return
            }

            guard let _ = authResult?.user else {
                print("Не удалось получить данные пользователя")
                self?.showError(message: "Не удалось получить данные пользователя")
                return
            }

            self?.errorLabel.isHidden = true
            let menuVC = MenuViewController()
            self?.navigationController?.pushViewController(menuVC, animated: true)
        }
    }

    private func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
}
