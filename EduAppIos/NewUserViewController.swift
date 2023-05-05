//
//  NewUserViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/2/23.
//

import Foundation

import UIKit

class NewUserViewController: UIViewController {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите ваше имя"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordTextFields: [UITextField] = {
        var textFields = [UITextField]()
        for _ in 0..<4 {
            let textField = UITextField()
            textField.textAlignment = .center
            textField.isSecureTextEntry = true
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            textFields.append(textField)
        }
        return textFields
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupNameLabel()
        setupNameTextField()
        setupPasswordStackView()
        setupSaveButton()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "New User"
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupNameTextField() {
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupPasswordStackView() {
        view.addSubview(passwordLabel)
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        for textField in passwordTextFields {
            passwordStackView.addArrangedSubview(textField)
        }
        
        view.addSubview(passwordStackView)
        NSLayoutConstraint.activate([
            passwordStackView.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordStackView.leadingAnchor.constraint(equalTo: passwordLabel
                .trailingAnchor, constant: 8),
            passwordStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupSaveButton() {
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // метод для сохранения информации о пользователе
    private func saveUser() {
        guard let name = nameTextField.text else { return }
        var password = ""
        for textField in passwordTextFields {
            guard let text = textField.text else { return }
            password += text
        }

    }
    

    @objc private func saveButtonTapped() {
        saveUser()
        navigationController?.popViewController(animated: true)
    }
}
