//
//  EditProfileViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/5/23.
//

import Foundation
import UIKit

class EditProfileViewController: UIViewController {

    let emailTextField = UITextField()
    let saveButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white

        setupEmailTextField()
        setupSaveButton()
    }

    private func setupEmailTextField() {
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Введите новый адрес электронной почты"

        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }

    private func setupSaveButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)

        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
    }

    @objc private func saveButtonPressed() {
        // Здесь вы можете обновить адрес электронной почты пользователя и сохранить его
        dismiss(animated: true, completion: nil)
    }
}
