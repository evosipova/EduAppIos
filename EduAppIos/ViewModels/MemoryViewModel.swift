//
//  MemoryViewController.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 3/13/23.
//


import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore


class MemoryViewModel: UIViewController {
    private let model = MemoryColletionModel()


    var label: UILabel! = {
        var label = UILabel()
        label.text = "memory".localized(MainViewController.language)
        label.font = UIFont(name: "Raleway-Bold", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        view.addSubview(label)
        label.pinCenterX(to: view)
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.06).isActive = true

        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "arrow.turn.up.left",withConfiguration: config)?.withTintColor(.white
                                                                                                       , renderingMode: .alwaysOriginal)

        let backButton = UIBarButtonItem()
        backButton.title = ""

        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image

        setupRectangle()
        setupButtons()
    }



    private func setupView() {
        self.view.backgroundColor = .white

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

    }

    private func createButton()->UIButton{
        let button = UIButton()
        button.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button.layer.borderColor = UIColor(red: 0.897, green: 0.897, blue: 0.897, alpha: 1).cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }

    func setupButtons(){
        var const1: CGFloat =  (model.viewRect.frame.width*0.2 - 10)/2
        var const2: CGFloat = (model.viewRect.frame.height-model.viewRect.frame.width*0.8-10)*0.3
        for i in 0...3 {
            model.buttons.append(createButton())
            view.addSubview(model.buttons[i])
            model.buttons[i].translatesAutoresizingMaskIntoConstraints = false;
            model.buttons[i].layer.frame = CGRect(x: 0, y: 0, width: model.viewRect.frame.width*0.8/2, height: model.viewRect.frame.width*0.8/2)

            model.buttons[i].widthAnchor.constraint(equalToConstant: model.viewRect.frame.width*0.8/2).isActive = true

            model.buttons[i].heightAnchor.constraint(equalToConstant: model.viewRect.frame.width*0.8/2).isActive = true

            model.buttons[i].leadingAnchor.constraint(equalTo: model.viewRect.leadingAnchor, constant: const1 ).isActive = true

            const1 += 5 + model.viewRect.frame.width*0.8/2
            model.buttons[i].topAnchor.constraint(equalTo: model.viewRect.topAnchor, constant: const2).isActive = true
            if((i+1)%2 == 0){
                const1 = (model.viewRect.frame.width*0.2 - 10)/2
                const2 += model.viewRect.frame.width*0.8/2 + 5
            }
        }

        let img1 = imageWithImage(image: UIImage(named: "pepper")!, scaledToSize: CGSize(width: model.buttons[0].frame.width - 5 , height: model.buttons[0].frame.height - 5))
        let img2 = imageWithImage(image: UIImage(named: "airplane")!, scaledToSize: CGSize(width: model.buttons[0].frame.width - 5 , height: model.buttons[0].frame.height - 5))
        let img3 = imageWithImage(image: UIImage(named: "cactus")!, scaledToSize: CGSize(width: model.buttons[0].frame.width - 5 , height: model.buttons[0].frame.height - 5))
        let img4 = imageWithImage(image: UIImage(named: "lion")!, scaledToSize: CGSize(width: model.buttons[0].frame.width - 5 , height: model.buttons[0].frame.height - 5))

        let imageView1 = UIImageView(image: img1)

        model.buttons[0].addSubview(imageView1)
        imageView1.pinCenter(to: model.buttons[0])

        let imageView2 = UIImageView(image: img2)

        model.buttons[1].addSubview(imageView2)
        imageView2.pinCenter(to: model.buttons[1])

        let imageView3 = UIImageView(image: img3)

        model.buttons[2].addSubview(imageView3)
        imageView3.pinCenter(to: model.buttons[2])

        let imageView4 = UIImageView(image: img4)

        model.buttons[3].addSubview(imageView4)
        imageView4.pinCenter(to: model.buttons[3])


        for button in model.buttons {
            button.addTarget(self ,action: #selector(pictureTapAction), for: .touchUpInside)

        }

        let continueButton = createButton()
        view.addSubview(continueButton)
        model.buttons.append(continueButton)

        continueButton.frame = CGRect(x: 0, y: 0, width: model.viewRect.frame.width*0.7, height: model.viewRect.frame.height*0.2)
        continueButton.layer.backgroundColor = UIColor(red: 0.553, green: 0.6, blue: 1, alpha: 0.3).cgColor
        continueButton.layer.cornerRadius = 20
        continueButton.layer.borderWidth = 0

        continueButton.translatesAutoresizingMaskIntoConstraints = false;
        continueButton.widthAnchor.constraint(equalToConstant: model.viewRect.frame.width*0.7).isActive = true

        continueButton.heightAnchor.constraint(equalToConstant: model.viewRect.frame.width*0.15).isActive = true


        continueButton.leadingAnchor.constraint(equalTo: model.viewRect.leadingAnchor, constant: model.viewRect.frame.width*0.15).isActive = true


        continueButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.8).isActive = true


        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: model.viewRect.frame.width*0.7, height: model.viewRect.frame.height*0.15)
        label.textColor = .white
        label.font = UIFont(name: "Raleway-Bold", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "continue".localized(MainViewController.language)
        continueButton.addSubview(label)
        label.pinCenter(to: continueButton)

        continueButton.isEnabled = false;
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)

    }


    private func setupRectangle() {
        model.viewRect.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.7)

        model.viewRect.backgroundColor = .white

        model.viewRect.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor


        let parent = self.view!

        parent.addSubview(model.viewRect)

        model.viewRect.translatesAutoresizingMaskIntoConstraints = false

        model.viewRect.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true

        model.viewRect.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true

        model.viewRect.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true

        model.viewRect.topAnchor.constraint(equalTo: parent.topAnchor, constant: view.frame.height*0.2).isActive = true

        model.viewRect.layer.cornerRadius = view.frame.width/9

        model.viewRect.clipsToBounds = true

        model.viewRect.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

    }

    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return newImage
    }

    @objc
    func pictureTapAction(_ sender: UIButton!){
        for (index, button) in model.buttons.enumerated() {
            button.layer.borderColor = UIColor(red: 0.897, green: 0.897, blue: 0.897, alpha: 1).cgColor
            button.layer.borderWidth = 3

            if button == sender {
                model.selectedCategoryIndex = index
            }
        }
        sender.layer.borderWidth = 5
        sender.layer.borderColor =  UIColor(red: 0.755, green: 0.962, blue: 0.417, alpha: 1).cgColor
        model.buttons[4].isEnabled = true
        model.buttons[4].layer.backgroundColor = UIColor(red: 0.553, green: 0.6, blue: 1, alpha: 1).cgColor
        model.buttons[4].layer.borderWidth = 0
    }


    @objc
    func continueButtonPressed() {
        if model.selectedCategoryIndex >= 0 && model.selectedCategoryIndex <= 3 {
            model.memoryCollectionController = MemoryCollectionViewController()
            model.memoryCollectionController.selectedCategoryIndex = model.selectedCategoryIndex

            navigationController?.pushViewController(model.memoryCollectionController, animated: true)
        }
    }

}
