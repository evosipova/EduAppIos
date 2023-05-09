//
//  EndGameViewController.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 10.03.2023.
//

import Foundation
import UIKit

class EndGameViewController: UIViewController {
    
    //мемори = 0, пазлы = 1, крестики-нолики = 2
    var initialcontrollerId: Int = 2
    
    var resLabel: UILabel! = {
        var resLabel = UILabel()
        resLabel.font = UIFont(name: "Raleway-Bold", size: 30)
        resLabel.font = UIFont.boldSystemFont(ofSize: 30)
        resLabel.textColor = .white
        resLabel.translatesAutoresizingMaskIntoConstraints = false
        return resLabel
    }()
    
    var buttonExit = UIButton()
    var buttonAgain = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtons()
    }
    
    private func setupView() {
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
        view.addSubview(resLabel)
        resLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.3).isActive = true
        resLabel.pinCenterX(to: view)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @objc
    func buttonExitPressed(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc
    func buttonAgainPressed(){
        if(initialcontrollerId == 0 || initialcontrollerId == 1){
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        }else{
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupButtons() {
        buttonExit.frame = CGRect(x: 0, y: 0, width: view.frame.width*0.7, height: view.frame.height*0.07)
        buttonExit.backgroundColor = .white
        buttonExit.layer.cornerRadius = 20
        
        let parent = self.view!
        parent.addSubview(buttonExit)
        buttonExit.translatesAutoresizingMaskIntoConstraints = false
        buttonExit.widthAnchor.constraint(equalToConstant: view.frame.width*0.7).isActive = true
        buttonExit.heightAnchor.constraint(equalToConstant: view.frame.height*0.07).isActive = true
        buttonExit.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: view.frame.width*0.15).isActive = true
        buttonExit.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.4).isActive = true
        
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: buttonExit.frame.width, height: buttonExit.frame.height*0.9)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.867, green: 0.651, blue: 1, alpha: 1)
        label.font = UIFont(name: "Raleway-Bold", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "exit".localized(MainViewController.language)
        
        buttonExit.addSubview(label)
        label.pinCenter(to: buttonExit)
        buttonExit.addTarget(self, action: #selector(buttonExitPressed), for: .touchUpInside)
        
        buttonAgain.frame = CGRect(x: 0, y: 0, width: view.frame.width*0.7, height: view.frame.height*0.07)
        buttonAgain.backgroundColor = .white
        buttonAgain.layer.cornerRadius = 20
        
        
        parent.addSubview(buttonAgain)
        buttonAgain.translatesAutoresizingMaskIntoConstraints = false
        buttonAgain.widthAnchor.constraint(equalToConstant: view.frame.width*0.7).isActive = true
        buttonAgain.heightAnchor.constraint(equalToConstant: view.frame.height*0.07).isActive = true
        buttonAgain.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: view.frame.width*0.15).isActive = true
        buttonAgain.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.5).isActive = true
        
        
        let label2 = UILabel()
        label2.frame = CGRect(x: 0, y: 0, width: buttonAgain.frame.width, height: buttonAgain.frame.height*0.9)
        label2.backgroundColor = .white
        label2.textColor = UIColor(red: 0.867, green: 0.651, blue: 1, alpha: 1)
        label2.font = UIFont(name: "Raleway-Bold", size: 18)
        label2.font = UIFont.boldSystemFont(ofSize: 18)
        label2.text = "play_again".localized(MainViewController.language)
        
        buttonAgain.addSubview(label2)
        label2.pinCenter(to: buttonAgain)
        
        
        buttonAgain.addTarget(self, action: #selector(buttonAgainPressed), for: .touchUpInside)
        
    }
}

