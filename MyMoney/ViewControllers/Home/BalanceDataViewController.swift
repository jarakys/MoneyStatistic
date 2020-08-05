//
//  BalanceDataViewController.swift
//  MyMoney
//
//  Created by Kirill on 31.05.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

class BalanceDataViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet weak var segmentControllerContainer: UIView!
    @IBOutlet weak var segmentControlView: SegmentControlView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var sumTextField: UITextField!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    var state: Category!
    var tabTitles = [Category.earn.string, Category.cost.string]

    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 15
        addButton.layer.masksToBounds = true
        addButton.backgroundColor = state.color()
        sumTextField.layer.cornerRadius = 15
        sumTextField.layer.masksToBounds = true
        sumTextField.layer.borderWidth = 1
        sumTextField.layer.borderColor = UIColor.gray.cgColor
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        segmentControllerContainer.roundCorners([.topRight,.topLeft], radius: 50)
        segmentControlView.roundCorners([.topRight,.topLeft], radius: 50)
        segmentControlView.delegate = self
        segmentControlView.setButtonTitiles(buttonTitiles: tabTitles)
        segmentControlView.selectorViewColor = state.color()
        categoriesCollectionView.roundCorners([.bottomLeft, .bottomRight], radius: 25)
        guard let index = tabTitles.firstIndex(of: state.string) else {
            fatalError("Invalid state")
        }
        updateColors()
        segmentControlView.setIndex(index: index)

    }

    func updateColors() {
//        self.navigationController?.navigationBar.tintColor = state.color()
        segmentControlView.selectorViewColor = state.color()
        addButton.backgroundColor = state.color()
    }
    
    @IBAction func addDidTap(_ sender: Any) {
        guard let text = sumTextField.text else { return }
        sumTextField.text = ""
    }
}

extension BalanceDataViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
        if let image = cell.viewWithTag(1) as? UIImageView {
            image.image = UIImage(named: "backIcon")
        } else if let label = cell.viewWithTag(2) as? UILabel {
            label.text = "10 000 hours Im coming!"
        }
        return cell
    }
}

extension BalanceDataViewController: UICollectionViewDelegate {
    
}

extension BalanceDataViewController : SegmentControlDelegate {
    func changeToIndex(index: Int) {
        state = Category(rawValue: index+1)
        updateColors()
    }
}
