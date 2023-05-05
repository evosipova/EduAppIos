//
//  RegistrationViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/2/23.
//

import Foundation
import Firebase
import FirebaseAuth
import UIKit
import FirebaseFirestore

class RegistrationViewController: UIViewController {
    private let emailTextField = UITextField()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let continueButton = UIButton()

    private var firestore: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        firestore = Firestore.firestore()
    }

    private func setupView() {
        view.backgroundColor = .white

        usernameTextField.borderStyle = .roundedRect
        usernameTextField.placeholder = "Введите ваше имя пользователя"
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false

        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Введите вашу почту"
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Введите ваш пароль"
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false



        continueButton.setTitle("Продолжить", for: .normal)
                continueButton.setTitleColor(.blue, for: .normal)
                continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
                view.addSubview(continueButton)
                continueButton.translatesAutoresizingMaskIntoConstraints = false



        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),



            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        continueButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20)
                    ])
    }

    @objc private func continueButtonTapped() {
           guard let email = emailTextField.text, let username = usernameTextField.text, let password = passwordTextField.text else { return }

           Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
               guard let strongSelf = self else { return }

               if let error = error {
                   print("Ошибка при создании пользователя: \(error.localizedDescription)")
                   return
               }

               guard let user = authResult?.user else { return }

               let userRef = strongSelf.firestore.collection("users").document(user.uid)
               let userData: [String: Any] = ["email": email, "username": username, "password" : password]

               userRef.setData(userData) { error in
                   if let error = error {
                       print("Ошибка при сохранении данных пользователя: \(error.localizedDescription)")
                       return
                   }

                   let menuVC = MenuViewController()
                   strongSelf.navigationController?.pushViewController(menuVC, animated: true)
               }
           }
       }
   }
