//
//  EduMenuButton.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 10.05.2023.
//

import UIKit

class EduMenuButton: UIButton{
    private var label:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(gameImage:
                   UIImage,
                   isPinnedCenter: Bool,
                   name: String) {
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let image = UIImage(systemName: "arrowtriangle.right.fill",withConfiguration: config)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        self.setImage(image, for: .normal)
        self.imageEdgeInsets.left = -self.frame.width*0.75
        
        
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height*0.9)
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont(name: "Raleway-Bold", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)

        label.text = name
        self.addSubview(label)
        if(isPinnedCenter){
            label.pinCenter(to: self)
        }else{
            label.pin(to: self, [.top : self.frame.height/5,.left : self.frame.width*0.25])
        }
        
        
        let imageView = UIImageView(image: gameImage)
        self.addSubview(imageView)
        imageView.pin(to: self, [.top: self.frame.height/3.6, .right: self.frame.width/40])
    }
    
    private func configureUI(){
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor(red: 0.554, green: 0.599, blue: 1, alpha: 1).cgColor
        self.layer.borderWidth = 2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
