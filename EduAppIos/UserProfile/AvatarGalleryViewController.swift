//
//  AvatarGalleryViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/5/23.
//

import Foundation
import UIKit


protocol AvatarGalleryDelegate: AnyObject {
    func didSelectAvatar(image: UIImage)
}

class AvatarGalleryViewController: UIViewController {

    var viewModel = DBViewModel()

    weak var delegate: AvatarGalleryDelegate?

    private let imageNames = ["user1", "user2", "user3", "user4", "user5", "user6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: "AvatarCell")
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 10

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 215).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    
}

extension AvatarGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as! AvatarCell
        let imageName = imageNames[indexPath.row]
        cell.configure(with: UIImage(named: imageName))
        return cell
    }
}

extension AvatarGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = UIImage(named: imageNames[indexPath.row])
        delegate?.didSelectAvatar(image: selectedImage!)

        if !viewModel.isNotAutrorised() {
            viewModel.updateAvatarName(newAvatarName: imageNames[indexPath.row]) { (result: Result<Void, Error>) in
                switch result {
                case .success:
                    print("Avatar name updated successfully")
                case .failure(let error):
                    print("Error updating avatar name: \(error.localizedDescription)")
                }
            }
        } else {
            UserDefaults.standard.set(imageNames[indexPath.row], forKey: "lastSelectedAvatar")
        }

        self.dismiss(animated: true, completion: nil)
    }
}


class AvatarCell: UICollectionViewCell {
    var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }

    private func setupImageView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8

        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    func configure(with image: UIImage?) {
        imageView.image = image
    }
}
