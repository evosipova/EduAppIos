//
//  ProfileViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/5/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, AvatarGalleryDelegate {

    let avatarImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white

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
    }

    @objc private func showAvatarGallery() {
        let avatarGalleryViewController = AvatarGalleryViewController()
        avatarGalleryViewController.delegate = self
        self.present(avatarGalleryViewController, animated: true, completion: nil)
    }

    func didSelectAvatar(image: UIImage) {
        avatarImageView.image = image
    }

    @objc
    private func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    private func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)

        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    }
}



