//
//  LoginViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/5/23.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    private let emailTextField:EduTextField = EduTextField()
    private let passwordTextField:EduTextField = EduTextField()
    private let continueButton = UIButton()
    private let errorLabel = UILabel()
    private var codeTextFields: [UITextField] = []
    let numberPadStackView = UIStackView()
    var viewModel = DBViewModel()
    
    
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
        hideKeyboardWhenTappedAround()
        setupView()
        bindViewModel()
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
    func bindViewModel(){
        viewModel.error_mes.bind({ (error_mes) in
            DispatchQueue.main.async {
                self.errorLabel.text = error_mes
            }
        })
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
    
    
    private func setupTextFields(){
        emailTextField.placeholder = "email".localized(MainViewController.language)
        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.setHeight(50),
            emailTextField.setWidth(80)])
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
    
    
    
    private func setupLabels(){
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.9)
        label.textColor = .black
        label.font = UIFont(name: "Raleway-Bold", size: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "log_in".localized(MainViewController.language)
        view.addSubview(label)
        label.pin(to: view, [.top: view.frame.height * 0.07])
        label.pinCenterX(to: view)
        
        let passLabel = UILabel()
        passLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.9)
        passLabel.textColor = .black
        passLabel.font = UIFont(name: "Raleway-Bold", size: 18)
        passLabel.font = UIFont.boldSystemFont(ofSize: 18)
        passLabel.text = "password".localized(MainViewController.language)
        view.addSubview(passLabel)
        passLabel.pin(to: view, [.top: view.frame.height * 0.315, .left: view.frame.width * 0.11])
        
        errorLabel.textColor = .red
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        //        errorLabel.isHidden = true
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            errorLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 600)
        ])
        
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
        label.text = "continue".localized(MainViewController.language)
        continueButton.addSubview(label)
        label.pinCenter(to: continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            continueButton.setHeight(Int(view.frame.height*0.07)),
            continueButton.setWidth(Int(view.frame.width*0.7))])
        
    }
    
    private func createCodeTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.textAlignment = .center
        textField.isUserInteractionEnabled = false
        // запретить вставку + клавиатуру
        
        // поч не работает потом починить
        textField.font = UIFont.init(name: "Montserrat-Medium", size: 20)
        textField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        textField.heightAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        return textField
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
            if codeTextFields.allSatisfy({ !($0.text?.isEmpty ?? true) }) {
                let enteredPassword = codeTextFields.map { $0.text! }.joined()
                passwordTextField.text = enteredPassword
                numberPadStackView.isHidden = true
                continueButton.isHidden = false
                continueButton.isEnabled = true
                
            }
        }
    }
    
    
    @objc private func continueButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if email.isEmpty || password.isEmpty {
            continueButton.isHidden = false
            if password.isEmpty {
                numberPadStackView.isHidden = false
            } else {
                numberPadStackView.isHidden = true
            }
            errorLabel.text = "error_complete_all_fields".localized(MainViewController.language)
            return
        }

        if !isValidEmail(email) {
            continueButton.isHidden = false
            if password.isEmpty {
                numberPadStackView.isHidden = false
            } else {
                numberPadStackView.isHidden = true
            }
            errorLabel.text = "error_enter_valid_email".localized(MainViewController.language)
            return
        }
        
        DispatchQueue.main.async {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if let error = error {
                    print("Failed to sign in with email: \(error.localizedDescription)")
                    strongSelf.errorLabel.text = "error_wrong_password".localized(MainViewController.language)
                    strongSelf.passwordTextField.text = ""
                    strongSelf.continueButton.isHidden = true
                } else {
                    strongSelf.viewModel.log_in(email: email, password: password)
                    if strongSelf.errorLabel.text == "" {
                        let menuVC = MenuViewController()
                        strongSelf.navigationController?.pushViewController(menuVC, animated: true)
                    }
                }
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func showError(errorMessage: String) {
        errorLabel.text = errorMessage
        numberPadStackView.isHidden = true
    }
    
    
}

extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func resetErrorState() {
        errorLabel.text = ""
        numberPadStackView.isHidden = false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        if (emailTextField.text != ""){
            
            if(passwordTextField.text?.count != 6){
                resetErrorState()
            }
        }
    }
}
