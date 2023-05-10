//
//  EduTextField.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 10.05.2023.
//

import UIKit
@IBDesignable
open class EduTextField : UITextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    private func configureUI() {
        self.borderStyle = .roundedRect
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.backgroundColor = UIColor.black.cgColor
        self.font = UIFont(name: "Raleway-Regular", size: 20)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setHeight(50)
        self.setWidth(80)
        
    }
}
