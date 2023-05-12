//
//  PuzzleCollectionViewController.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 12.03.2023.
//

import Foundation
import UIKit


class PuzzleCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    var viewModel = PuzzleCollectionViewModel()
    var endGameController = EndGameViewController()
    
    var infoButton: UIButton!
    var rulesView: UIView!
    var rulesLabel: UILabel!
    
    var viewRect = UIView()
    var collectionView: UICollectionView!
    
    var label: UILabel! = {
        var label = UILabel()
        label.text = "puzzle".localized(MainViewController.language)
        label.font = UIFont(name: "Raleway-Bold", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRectangle()
        setupCollectionView()
        setupInfoButton()
        setupBackButton()
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        
        
    }
    
    func setupBackButton(){
           let config = UIImage.SymbolConfiguration(textStyle: .title1)
           let image = UIImage(systemName: "arrow.turn.up.left",withConfiguration: config)?.withTintColor(.white
                                                                                                          , renderingMode: .alwaysOriginal)
           
           let backButton = UIBarButtonItem()
           backButton.title = ""
           
           self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
           
           self.navigationController?.navigationBar.backIndicatorImage = image
           self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
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
        
        view.addSubview(label)
        label.pinCenterX(to: view)
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.06).isActive = true
        
        
    }
    func setupRectangle(){
        
        viewRect.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.7)
        
        viewRect.backgroundColor = .white
        
        
        viewRect.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        let parent = self.view!
        
        parent.addSubview(viewRect)
        
        viewRect.translatesAutoresizingMaskIntoConstraints = false
        
        
        viewRect.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        viewRect.heightAnchor.constraint(equalToConstant: view.frame.height*0.7).isActive = true
        
        viewRect.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        
        viewRect.topAnchor.constraint(equalTo: parent.topAnchor, constant: view.frame.height*0.15).isActive = true
        
        viewRect.layer.cornerRadius = view.frame.width/9
        
        viewRect.clipsToBounds = true
    }
    
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .none
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 35
        self.view.addSubview(collectionView)
    }
    
    
    private func setupRulesView() {
        let rulesViewWidth = view.frame.width * 0.75
        let rulesViewHeight = view.frame.height * 0.35
        let rulesViewSize = CGSize(width: rulesViewWidth, height: rulesViewHeight)
        
        rulesView = UIView(frame: CGRect(origin: .zero, size: rulesViewSize))
        rulesView.center = view.center
        rulesView.backgroundColor = .white
        rulesView.layer.cornerRadius = 10
        rulesView.clipsToBounds = true
        rulesView.isHidden = true
        rulesView.layer.borderColor = UIColor.black.cgColor
        rulesView.layer.borderWidth = 2.0
        
        
        
        let rulesLabel = UILabel()
        rulesLabel.text = "puzzle_rules".localized(MainViewController.language)
        rulesLabel.numberOfLines = 0
        rulesLabel.textAlignment = .center
        rulesLabel.font = UIFont.systemFont(ofSize: 20)
        rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        rulesView.addSubview(rulesLabel)
        NSLayoutConstraint.activate([
            rulesLabel.leadingAnchor.constraint(equalTo: rulesView.leadingAnchor, constant: 10),
            rulesLabel.trailingAnchor.constraint(equalTo: rulesView.trailingAnchor, constant: -10),
            rulesLabel.topAnchor.constraint(equalTo: rulesView.topAnchor, constant: 10),
            rulesLabel.bottomAnchor.constraint(equalTo: rulesView.bottomAnchor, constant: -10)
        ])
        
        view.addSubview(rulesView)
    }
    
    @objc private func infoButtonTapped() {
        if rulesView == nil {
            setupRulesView()
        }
        
        rulesView.isHidden = !rulesView.isHidden
    }
    
    private let infoButtonConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)
    
    private func setupInfoButton() {
        infoButton = UIButton(type: .system)
        infoButton.setImage(UIImage(systemName: "questionmark.circle", withConfiguration: infoButtonConfig), for: .normal)
        infoButton.tintColor = .white
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        view.addSubview(infoButton)
        infoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    private func gameEnd(){
           let imgView = viewModel.getImgView(size : CGSize(width: viewRect.bounds.width, height: viewRect.bounds.width))
           view.addSubview(imgView)
           imgView.pinCenter(to: view)
           
           endGameController.initialcontrollerId = 1
           endGameController.resLabel.text = "Победа!"
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               self.navigationController?.pushViewController(self.endGameController, animated: true)
           }
           
       }
    
    
}

extension PuzzleCollectionViewController{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return viewModel.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    
}





extension PuzzleCollectionViewController: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {

           let item = viewModel.getItem(indexPath: indexPath)
           let itemProvider = NSItemProvider(object: item as NSString)
           let dragItem = UIDragItem(itemProvider: itemProvider)
           dragItem.localObject = dragItem
           return [dragItem]
       }
}




extension PuzzleCollectionViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidEnd session: UIDropSession) {
           if viewModel.chechGameEnd() {
               
               collectionView.dragInteractionEnabled = false
               
               collectionView.isHidden = true
               gameEnd()
               
               
           }
       }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
           if collectionView.hasActiveDrag {
               return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
           }
           return UICollectionViewDropProposal(operation: .forbidden)
       }
       
       func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
           
           var destinationIndexPath: IndexPath
           if let indexPath = coordinator.destinationIndexPath {
               destinationIndexPath = indexPath
           } else {
               let row = collectionView.numberOfItems(inSection: 0)
               destinationIndexPath = IndexPath(item: row - 1, section: 0)
           }
           
           if coordinator.proposal.operation == .move {
               self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
               self.collectionView.reloadData()
           }
       }
       
      func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath:IndexPath, collectionView: UICollectionView) {
           
          viewModel.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
       }
   }

   extension PuzzleCollectionViewController : UICollectionViewDelegateFlowLayout {
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: view.frame.height*0.15, left: 0, bottom: 0, right: 0)
           
       }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
    }
    
}
