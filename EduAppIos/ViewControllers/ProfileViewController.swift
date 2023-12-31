//
//  ProfileViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/5/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, AvatarGalleryDelegate {
    var viewModel = DBViewModel()
    var currentUser: DBViewModel.User?

    var infoView: UIView?
    var isInfoViewVisible = false

    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let editButton = UIButton(type: .system)

    let languageButton = UIButton(type: .system)

    func didSelectAvatar(image: UIImage) {
        avatarImageView.image = image
    }


    func didSelectAvatar(image: UIImage, imageName: String) {
        avatarImageView.image = image
        saveAvatar(avatarImage: image)
        viewModel.updateAvatarName(newAvatarName: imageName) { (result: Result<Void, Error>) in
            switch result {
            case .success:
                print("Avatar name updated successfully")
            case .failure(let error):
                print("Error updating avatar name: \(error.localizedDescription)")
            }
        }
    }

    private func saveAvatarName(avatarName: String) {
        UserDefaults.standard.set(avatarName, forKey: "selectedAvatarName")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchUserData()
        if viewModel.isNotAutrorised() {
            if let lastSelectedAvatar = UserDefaults.standard.string(forKey: "lastSelectedAvatar") {
                avatarImageView.image = UIImage(named: lastSelectedAvatar)
            }
        }
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
        logoutButton.setTitle("exit".localized(MainViewController.language), for: .normal)


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

        setupInfoButton()
    }


    private func setupInfoButton() {
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        let infoImage = UIImage(systemName: "info.circle", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal)

        let infoButton = UIButton(type: .system)
        infoButton.setImage(infoImage, for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)

        view.addSubview(infoButton)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoButton.widthAnchor.constraint(equalToConstant: 30),
            infoButton.heightAnchor.constraint(equalToConstant: 30)
        ])

        setupLanguageButton()
    }


    private func setupLanguageButton() {
        if(MainViewController.language == "ru"){
            languageButton.setTitle("Русский", for: .normal)
        }else {
            languageButton.setTitle("English", for: .normal)
        }

        languageButton.setTitleColor(.white, for: .normal)
        languageButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        languageButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)

        view.addSubview(languageButton)
        languageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            languageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            languageButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            languageButton.widthAnchor.constraint(equalToConstant: 100),
            languageButton.heightAnchor.constraint(equalToConstant: 40)
        ])

    }

    @objc private func languageButtonTapped() {
        if languageButton.currentTitle == "Русский" {
            languageButton.setTitle("English", for: .normal)
            Localize.setCurrentLanguage("en")
            MainViewController.language = "en"
            let lisVc = self.navigationController!.viewControllers
            for controller in lisVc {
                controller.viewDidLoad()
            }


        } else {
            languageButton.setTitle("Русский", for: .normal)
            Localize.setCurrentLanguage("ru")
            MainViewController.language = "ru"

            let lisVc = self.navigationController!.viewControllers
            for controller in lisVc {
                controller.viewDidLoad()
            }
        }
        updateLabels()
    }


    @objc private func infoButtonTapped() {
        if isInfoViewVisible {
            infoView?.removeFromSuperview()
        } else {
            let infoViewSize = CGSize(width: view.frame.width * 0.75, height: view.frame.height * 0.35)
            infoView = UIView(frame: CGRect(origin: .zero, size: infoViewSize))
            infoView?.backgroundColor = .white
            infoView?.center = view.center
            infoView?.layer.cornerRadius = 10
            infoView?.layer.borderColor = UIColor.black.cgColor
            infoView?.layer.borderWidth = 1


            let infoLabel = UILabel(frame: CGRect(x: 10, y: 10, width: infoView!.frame.width - 20, height: infoView!.frame.height - 20))

            let string = "about_us".localized(MainViewController.language)

            let attributedString = NSMutableAttributedString(string: string)

            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: (MainViewController.language == "ru" ? 5 : 8)))
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 7, length: 27))
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 74, length: 7))

            infoLabel.attributedText = attributedString

            infoLabel.textAlignment = .center
            infoLabel.numberOfLines = 0

            infoView?.addSubview(infoLabel)
            view.addSubview(infoView!)
        }
        isInfoViewVisible.toggle()
    }


    private func loadAvatar() {
        if let avatarName = currentUser?.avatarName {
            avatarImageView.image = UIImage(named: avatarName)
        }
    }


    private func saveAvatar(avatarImage: UIImage) {
        if let avatarData = avatarImage.pngData() {
            UserDefaults.standard.set(avatarData, forKey: "selectedAvatar")
        }
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
        titleLabel.text = "settings".localized(MainViewController.language)
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
        viewModel.fetchUserData { [weak self] (result: Result<DBViewModel.User, Error>) in
            guard let strongSelf = self else { return }

            switch result {
            case .success(let fetchedUser):
                strongSelf.currentUser = fetchedUser
                strongSelf.updateLabels()
                strongSelf.loadAvatar()
            case .failure(let error):
                print("error_fetching_user_info" + " \(error.localizedDescription)")
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


