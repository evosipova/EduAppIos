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
    private let errorLabel = UILabel()
    let numberPadStackView = UIStackView()
    private var firestore: Firestore!
    private var codeTextFields: [UITextField] = []
    
    
    
    private let numberButtons: [UIButton] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0].map { number in
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
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        button.setImage(UIImage(systemName: "delete.left", withConfiguration: config), for: .normal)
        button.tintColor = UIColor(red: 0.553, green: 0.6, blue: 1, alpha: 1)
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
        hideKeyboardWhenTappedAround()
        firestore = Firestore.firestore()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        setupTextFields()
        setupBackButton()
        setupLabels()
        setupCodeTextFields()
        setupPasswordInputButtons()
        setupContinueButton()
        
        
    }
    
    private func createCodeTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.textAlignment = .center
        textField.isUserInteractionEnabled = false
        // поч не работает потом починить
        textField.font = UIFont.init(name: "Montserrat-Medium", size: 20)
        textField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        textField.heightAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        return textField
    }
    
    private func setupContinueButton(){
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(continueButton)
        continueButton.isHidden = true
        
        continueButton.frame = CGRect(x: 0, y: 0, width: view.frame.width*0.7, height: view.frame.height*0.07)
        continueButton.layer.backgroundColor = UIColor(red: 0.553, green: 0.6, blue: 1, alpha: 1).cgColor
        continueButton.layer.cornerRadius = 20
        continueButton.layer.borderWidth = 0
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width*0.7, height: view.frame.height*0.07)
        label.textColor = .white
        label.font = UIFont(name: "Raleway-Bold", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "продолжить"
        continueButton.addSubview(label)
        label.pinCenter(to: continueButton)
        
        NSLayoutConstraint.activate([
            
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            continueButton.setHeight(Int(view.frame.height*0.07)),
            continueButton.setWidth(Int(view.frame.width*0.7))])
        
    }
    private func setupPasswordInputButtons(){
        
        
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
                        rowStackView.arrangedSubviews.last?.backgroundColor = .clear
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
            numberPadStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.45)
        ])
        numberPadStackView.isHidden = true
        
    }
    
    private func setupCodeTextFields(){
        codeTextFields = (0..<6).map { _ in createCodeTextField() }
        let codeStackView = UIStackView(arrangedSubviews: codeTextFields)
        codeStackView.axis = .horizontal
        codeStackView.spacing = 8
        view.addSubview(codeStackView)
        codeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            codeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
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
        
    }
    
    private func setupBackButton(){
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "arrow.turn.up.left",withConfiguration: config)?.withTintColor(.black
                                                                                                       , renderingMode: .alwaysOriginal)
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
    }
    
    private func setupTextFields(){
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.cornerRadius = 10
        usernameTextField.layer.borderColor = UIColor.black.cgColor
        usernameTextField.font = UIFont(name: "Raleway-Regular", size: 20)
        usernameTextField.placeholder = "имя"
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.placeholder = "почта"
        emailTextField.font = UIFont(name: "Raleway-Regular", size: 20)
        emailTextField.autocapitalizationType = .none
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameTextField.setHeight(50),
            usernameTextField.setWidth(80),
            
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.setHeight(50),
            emailTextField.setWidth(80)])
        
        
    }
    
    private func setupLabels(){
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.9)
        label.textColor = .black
        label.font = UIFont(name: "Raleway-Bold", size: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "регистрация"
        view.addSubview(label)
        label.pin(to: view, [.top: view.frame.height * 0.07])
        label.pinCenterX(to: view)
        
        let passLabel = UILabel()
        passLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.9)
        passLabel.textColor = .black
        passLabel.font = UIFont(name: "Raleway-Bold", size: 18)
        passLabel.font = UIFont.boldSystemFont(ofSize: 18)
        passLabel.text = "пароль"
        view.addSubview(passLabel)
        passLabel.pin(to: view, [.top: view.frame.height * 0.315, .left: view.frame.width * 0.11])
        
        errorLabel.textColor = .red
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            errorLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 600)
        ])
        
    }
    
    
    
    
    @objc private func continueButtonTapped() {
        
        // починить
        guard let email = emailTextField.text, let username = usernameTextField.text, let password = passwordTextField.text else { return }
        
        if email.isEmpty || username.isEmpty || password.isEmpty {
            //continueButton.isHidden = true
            if(password.isEmpty){
                numberPadStackView.isHidden = false
            }else{
                numberPadStackView.isHidden = true
            }
            showError(message: "Пожалуйста, заполните все поля.")
            
            return
        }
        
        // Проверка корректности введенной почты
        if !isValidEmail(email) {
            if(password.isEmpty){
                numberPadStackView.isHidden = false
            }else{
                numberPadStackView.isHidden = true
            }
            showError(message: "Пожалуйста, введите корректный адрес электронной почты.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("Ошибка при создании пользователя: \(error.localizedDescription)")
                strongSelf.showError(message: "Ошибка при создании пользователя: \(error.localizedDescription)")
                return
            }
            
            guard let user = authResult?.user else { return }
            
            let userRef = strongSelf.firestore.collection("users").document(user.uid)
            let userData: [String: Any] = ["email": email, "username": username, "password" : password]
            
            userRef.setData(userData) { error in
                if let error = error {
                    print("Ошибка при сохранении данных пользователя: \(error.localizedDescription)")
                    strongSelf.showError(message: "Ошибка при сохранении данных пользователя: \(error.localizedDescription)")
                    return
                }
                
                strongSelf.errorLabel.isHidden = true
                let menuVC = MenuViewController()
                strongSelf.navigationController?.pushViewController(menuVC, animated: true)
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    
    
    
    
    @objc private func deleteButtonTapped() {
        if let lastFilledTextField = codeTextFields.last(where: { !($0.text?.isEmpty ?? true) }) {
            lastFilledTextField.text = ""
        }
    }
    
    
    @objc private func numberButtonTapped(sender: UIButton) {
        let number = sender.tag
        if let emptyTextField = codeTextFields.first(where: { $0.text?.isEmpty ?? false }) {
            emptyTextField.text = "\(number)"
            
            // Если все текстовые поля заполнены, проверьте пароль
            if codeTextFields.allSatisfy({ !($0.text?.isEmpty ?? true) }) {
                let enteredPassword = codeTextFields.map { $0.text! }.joined()
                passwordTextField.text = enteredPassword
                numberPadStackView.isHidden = true
                continueButton.isHidden = false
                continueButton.isEnabled = true
                
            }
        }
    }
    
    
    
    
}



extension RegistrationViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        if (emailTextField.text != "") && (usernameTextField.text != ""){
            
            if(passwordTextField.text?.count != 6){
                numberPadStackView.isHidden = false
            }
        }
    }
}
