//
//  BalanceDataViewController.swift
//  MyMoney
//
//  Created by Kirill on 31.05.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit
import CoreData

class BalanceDataViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet private weak var sumStackView: UIStackView!
    @IBOutlet private weak var segmentControllerContainer: UIView!
    @IBOutlet private weak var segmentControlView: SegmentControlView!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var sumTextField: UITextField!
    @IBOutlet private weak var categoriesCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var categoriesCollectionView: UICollectionView!
    
    private var tabTitles = [Category.earn.string, Category.cost.string]
    
    private lazy var categories: NSFetchedResultsController<Categories> = {
        DatabaseManager.shared.getCateogriesFetchController()
    }()
    
    private var category: Categories?
    
    public var state: Category = .balance

    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesCollectionView.register(CategoryCell.nib, forCellWithReuseIdentifier: CategoryCell.reusableIndentify)
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
        updateColors()
        registerKeyboardNotification()
        changeToIndex(index: tabTitles.firstIndex(of: state.string) ?? 0)
    }

    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func updateColors() {
        segmentControlView.selectorViewColor = state.color()
        addButton.backgroundColor = state.color()
    }
    
    @IBAction private func addDidTap(_ sender: Any) {
        guard let text = sumTextField.text else { return }
        sumTextField.resignFirstResponder()
        sumTextField.text = ""
        DatabaseManager.shared.createReport(category: category, currency: nil, value: Float(text) ?? 0.0)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let sumStackViewYPoint = sumStackView.frame.origin.y + sumStackView.frame.height + 20
            if sumStackViewYPoint > keyboardSize.origin.y {
                let size = sumStackViewYPoint - keyboardSize.origin.y
                UIView.animate(withDuration: 1, animations: {[unowned self] in
                    self.categoriesCollectionViewHeightConstraint.constant = -size
                    self.categoriesCollectionView.layoutSubviews()
                })
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification){
        if categoriesCollectionViewHeightConstraint.constant != 0 {
            UIView.animate(withDuration: 1, animations: {[unowned self] in
                self.categoriesCollectionViewHeightConstraint.constant = 0
                self.categoriesCollectionView.layoutSubviews()
            })
        }
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension BalanceDataViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (categories.fetchedObjects ?? []).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reusableIndentify, for: indexPath)
        let category = categories.fetchedObjects?[indexPath.row]
        (cell as? CategoryCell)?.configure(mainCategory: Category(rawValue: Int(category?.mainCategory ?? 0)), text: category?.name ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = state.color()
        }
        category = categories.fetchedObjects?[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = nil
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = categories.fetchedObjects?[indexPath.row]
        return CGSize(width: calculateCellWidth(for: category?.name), height: 50)
    }
    
    private func calculateCellWidth(for text: String?) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 17)
        let width = (text?.size(withAttributes: [NSAttributedString.Key.font : font as Any]).width ?? 50) + 60
        return width
    }
}

// MARK: SegmentControlDelegate
extension BalanceDataViewController : SegmentControlDelegate {
    func changeToIndex(index: Int) {
        state = Category(rawValue: index+1)
        updateColors()
        categories.fetchRequest.predicate = NSPredicate(format: "mainCategory == %@", NSNumber(value: state.rawValue))
        try? categories.performFetch()
        categoriesCollectionView.reloadData()
    }
}

// MARK: NSFetchedResultsControllerDelegate
extension BalanceDataViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        categoriesCollectionView.reloadData()
    }
}

