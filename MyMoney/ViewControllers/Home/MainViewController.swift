//
//  MainViewController.swift
//  MyMoney
//
//  Created by Kirill on 16.02.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var segmentControlView: SegmentControlView!
    @IBOutlet weak var floatButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    var state: Category = .balance {
        didSet {
            setColor()
            updateCardInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.label
        titleLabel.textColor = UIColor.label
        segmentControlView.delegate = self
        segmentControlView.setButtonTitiles(buttonTitiles: [Category.balance.string, Category.earn.string, Category.cost.string])
        segmentControlView.selectorViewColor = state.color()
        updateCardInfo()
        cardImageView.image = UIImage(named: state.image)!
        floatButton.layer.masksToBounds = true
        floatButton.layer.cornerRadius = floatButton.frame.width / 2
        categoryLabel.text = state.string
        dateLabel.text = Date().getFormatDate(format: "dd.MM.YYYY")
    }
    
    private func setColor() {
        segmentControlView.selectorViewColor = state.color()
        UIView.animate(withDuration: 0.15, animations: { [unowned self] in
            self.cardImageView.alpha = 0
            self.floatButton.backgroundColor = self.state.color()
            self.floatButton.alpha = self.state.isEditable ? 1 : 0
            }, completion: {[unowned self] res in
                self.cardImageView.image = UIImage(named: self.state.image)!
                UIView.animate(withDuration: 0.15, animations: {  [unowned self] in
                    self.cardImageView.alpha = 1
                })
        })
    }
    
    private func updateCardInfo() {
        var action: () -> Float
        switch state {
        case .balance:
            action = DatabaseManager.shared.getBalance
        case .cost:
            action = DatabaseManager.shared.getSpent
        case .earn:
            action = DatabaseManager.shared.getEarn
        }
        sumLabel.text = action().description
        categoryLabel.text = state.string
    }
    
    @IBAction func floatButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard.storyboard(storyboard: .home)
        let balanceDataViewController: BalanceDataViewController = storyboard.instantiateViewController()
        balanceDataViewController.state = state
        self.navigationController?.delegate = self
        self.navigationController?.pushViewController(balanceDataViewController, animated: true)
    }
    
    // MARK: - Navigation
    @IBAction func statisticsDidTap(_ sender: Any) {
        let storyboard = UIStoryboard.storyboard(storyboard: .home)
        let statisticViewController: StatisticViewController = storyboard.instantiateViewController()
        self.navigationController?.pushViewController(statisticViewController, animated: true)
    }
}

extension MainViewController : SegmentControlDelegate {
    func changeToIndex(index: Int) {
        state = Category(rawValue: index)
    }
}
