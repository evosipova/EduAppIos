//
//  EduGradientButton.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 08.05.2023.
//

import UIKit

final class EduGradientButton: UIView {
    private var button: UIButton = UIButton()
    var action: (() -> Void)?
    
    var title: String? {
        get {
            button.title(for: .normal)
        }
        set {
            button.setTitle(newValue, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        button.setTitle(title, for: .normal)
    }
    
    private func configureUI() {
        let image = UIImage(named: "grad_buttons")
        let containerView = UIImageView(image: image)
        containerView.contentMode =  UIView.ContentMode.scaleAspectFit
        containerView.isUserInteractionEnabled = true
        button.titleLabel!.font = UIFont(name: "Raleway-Bold", size: 17)
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(wasTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        
        containerView.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 2),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2)
        ])
       
        addSubview(containerView)
        containerView.pinLeft(to: self)
        containerView.pinRight(to: self)
        containerView.pinTop(to: self)
        containerView.pinBottom(to: self)
    }
    
    @objc
    private func wasTapped() {
        action?()
    }
}
