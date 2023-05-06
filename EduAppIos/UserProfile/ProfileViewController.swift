//
//  ProfileViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/5/23.
//

import Foundation
import UIKit
import Firebase


class ProfileViewController: UIViewController, AvatarGalleryDelegate {
    
    struct User {
        let username: String
        let email: String
    }
    
    var currentUser: User?
    
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let editButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
        setupView()
        loadSavedAvatar()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        setupBackButton()
        self.view.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
        let layer0 = CAGradientLayer()
        layer0.colors = [
            UIColor(red: 0.554, green: 0.599, blue: 1, alpha: 1).cgColor,
            
            UIColor(red: 0.867, green: 0.65, blue: 1, alpha: 1).cgColor,
        ]
        layer0.locations = [0, 1]
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        
        layer0.frame = view.frame
        view.layer.addSublayer(layer0)
        
        setupTitleLabel()
        setupBackButton()
        setupAvatarImageView()
        
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Выйти", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logoutButton.widthAnchor.constraint(equalToConstant: 100),
            logoutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
    }
    
    private func loadSavedAvatar() {
        if let avatarData = UserDefaults.standard.object(forKey: "selectedAvatar") as? Data,
           let avatarImage = UIImage(data: avatarData) {
            avatarImageView.image = avatarImage
        }
    }
    
    private func saveAvatar(avatarImage: UIImage) {
        if let avatarData = avatarImage.pngData() {
            UserDefaults.standard.set(avatarData, forKey: "selectedAvatar")
        }
    }
    
    func didSelectAvatar(image: UIImage) {
        avatarImageView.image = image
        saveAvatar(avatarImage: image)
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
    
    
    @objc private func logoutButtonTapped() {
        let mainViewController = MainViewController()
        
        let navigation = UINavigationController(rootViewController: mainViewController)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    private func setupTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.text = "настройки"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    }
    
    private func setupAvatarImageView() {
        
        
        avatarImageView.image = UIImage(named: "user1")
        avatarImageView.layer.cornerRadius = 60
        avatarImageView.clipsToBounds = true
        
        view.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let avatarButton = UIButton(type: .system)
        avatarButton.addTarget(self, action: #selector(showAvatarGallery), for: .touchUpInside)
        view.addSubview(avatarButton)
        avatarButton.translatesAutoresizingMaskIntoConstraints = false
        avatarButton.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor).isActive = true
        avatarButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
        avatarButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        avatarButton.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        
        setupNameLabel()
        setupEmailLabel()
    }
    
    func fetchUserData() {
        guard let user = Auth.auth().currentUser else {
            currentUser = User(username: "", email: "")
            updateLabels()
            return
        }
        
        let userRef = Firestore.firestore().collection("users").document(user.uid)
        
        userRef.getDocument { [weak self] (document, error) in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("Ошибка при получении данных пользователя: \(error.localizedDescription)")
            } else if let document = document, document.exists {
                if let data = document.data() {
                    strongSelf.currentUser = User(username: data["username"] as? String ?? "",
                                                  email: data["email"] as? String ?? "")
                    strongSelf.updateLabels()
                }
            }
        }
    }
    
    
    func updateLabels() {
        nameLabel.text = currentUser?.username ?? ""
        emailLabel.text = currentUser?.email ?? ""
    }
    
    
    
    private func setupNameLabel() {
        nameLabel.text = currentUser?.username ?? ""
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.textColor = .white
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20).isActive = true
    }
    
    private func setupEmailLabel() {
        emailLabel.text = currentUser?.email ?? ""
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textColor = .white
        
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    
    @objc private func showAvatarGallery() {
        let avatarGalleryViewController = AvatarGalleryViewController()
        avatarGalleryViewController.delegate = self
        self.present(avatarGalleryViewController, animated: true, completion: nil)
    }
    
    
    @objc
    private func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}



