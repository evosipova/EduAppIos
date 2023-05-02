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
       private var codeTextFields: [UITextField] = []
    
    private var randomPassword: String?
    
       private let numberButtons: [UIButton] = (0...9).map { number in
           let button = UIButton(type: .system)
           button.setTitle("\(number)", for: .normal)
           button.tintColor = .gray
           button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
           button.tag = number
           button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)

           button.layer.cornerRadius = 40
               button.clipsToBounds = true
               button.backgroundColor = UIColor(white: 0.9, alpha: 1)
               button.widthAnchor.constraint(equalToConstant: 80).isActive = true
               button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true


           return button
       }
    
    private let errorMessageLabel: UILabel = {
           let label = UILabel()
           label.textColor = .red
           label.textAlignment = .center
           label.text = "Неверный пароль"
           label.isHidden = true
           return label
       }()
       
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "delete.left"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true

        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func createCodeTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
        textField.textAlignment = .center
        textField.isUserInteractionEnabled = false
        textField.widthAnchor.constraint(equalToConstant: 48).isActive = true
        textField.heightAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        return textField
    }

    
    private func setupView() {
        view.backgroundColor = .white
           codeTextFields = (0..<4).map { _ in createCodeTextField() }

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
               emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
               emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
               emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

               sendCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               sendCodeButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20)
           ])

        
           let spacerView = UIView()
           view.addSubview(spacerView)
           spacerView.translatesAutoresizingMaskIntoConstraints = false
           spacerView.heightAnchor.constraint(equalToConstant: 30).isActive = true

           NSLayoutConstraint.activate([
               spacerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               spacerView.topAnchor.constraint(equalTo: sendCodeButton.bottomAnchor),
               spacerView.widthAnchor.constraint(equalTo: emailTextField.widthAnchor)
           ])
        
        
        let codeStackView = UIStackView(arrangedSubviews: codeTextFields)
           codeStackView.axis = .horizontal
           codeStackView.spacing = 8
           view.addSubview(codeStackView)
           codeStackView.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
               codeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               codeStackView.topAnchor.constraint(equalTo: spacerView.bottomAnchor),
               codeStackView.widthAnchor.constraint(equalTo: emailTextField.widthAnchor)
           ])
        
           for i in 1..<codeTextFields.count {
               let textField = codeTextFields[i]
               let previousTextField = codeTextFields[i - 1]
               textField.widthAnchor.constraint(equalTo: previousTextField.widthAnchor).isActive = true
               textField.heightAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
           }

           codeTextFields[0].widthAnchor.constraint(equalToConstant: 48).isActive = true
           codeTextFields[0].heightAnchor.constraint(equalTo: codeTextFields[0].widthAnchor).isActive = true

        view.addSubview(errorMessageLabel)
               errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
               
               NSLayoutConstraint.activate([
                   errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   errorMessageLabel.topAnchor.constraint(equalTo: codeStackView.bottomAnchor, constant: 20),
                   errorMessageLabel.widthAnchor.constraint(equalTo: emailTextField.widthAnchor)
               ])
               
               let numberPadStackView = UIStackView()
               numberPadStackView.axis = .vertical
               numberPadStackView.spacing = 16
               
               let numberOfRows = 4
               let numberOfColumns = 3
               
        for i in 0..<numberOfRows {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.spacing = 16
            rowStackView.distribution = .equalSpacing

            for j in 0..<numberOfColumns {
                let index = i * numberOfColumns + j
                if i == numberOfRows - 1 {
                    if j == 0 {
                        let emptyView = UIView()
                                      let emptyViewWidth: CGFloat = 86
                                      emptyView.widthAnchor.constraint(equalToConstant: emptyViewWidth).isActive = true
                                      rowStackView.addArrangedSubview(emptyView)
                    } else if j == 1 {
                        rowStackView.addArrangedSubview(numberButtons[9])
                    } else if j == numberOfColumns - 1 {
                        rowStackView.addArrangedSubview(deleteButton)
                    }
                } else if index < numberButtons.count - 1 {
                    rowStackView.addArrangedSubview(numberButtons[index])
                }
            }

            numberPadStackView.addArrangedSubview(rowStackView)
        }
               view.addSubview(numberPadStackView)
               numberPadStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                  numberPadStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                  numberPadStackView.topAnchor.constraint(equalTo: codeStackView.bottomAnchor, constant: 80) 
              ])
    }
    
    @objc private func sendCodeButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
                   print("Неверный адрес электронной почты")
                   return
               }

               randomPassword = generateRandomPassword()
               print("Сгенерированный пароль: \(randomPassword ?? "")")

               print("Отправка кода на адрес: \(email)")

               codeTextFields.forEach { $0.text = "" }
    }
    
    private func generateRandomPassword(length: Int = 4) -> String {
           let characters = "0123456789"
           return String((0..<length).map { _ in characters.randomElement()! })
       }
    
    @objc private func numberButtonTapped(sender: UIButton) {
        let number = sender.tag
                if let emptyTextField = codeTextFields.first(where: { $0.text?.isEmpty ?? false }) {
                    emptyTextField.text = "\(number)"

                    // Если все текстовые поля заполнены, проверьте пароль
                    if codeTextFields.allSatisfy({ !($0.text?.isEmpty ?? true) }) {
                        let enteredPassword = codeTextFields.map { $0.text! }.joined()
                        checkPassword(enteredPassword)
                    }
                }
      }
      
    private func checkPassword(_ enteredPassword: String) {
           if enteredPassword == randomPassword {
               print("Пароль верный")
               errorMessageLabel.isHidden = true
               
        
               let newUserViewController = NewUserViewController()
               navigationController?.pushViewController(newUserViewController, animated: true)
           } else {
               print("Пароль неверный")
               errorMessageLabel.isHidden = false
           }
       }
    
      @objc private func deleteButtonTapped() {
          if let lastFilledTextField = codeTextFields.last(where: { !($0.text?.isEmpty ?? true) }) {
              lastFilledTextField.text = ""
          }
      }
}
