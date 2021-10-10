//
//  StatisticViewController.swift
//  MyMoney
//
//  Created by Kirill on 05.03.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit
import Charts

class StatisticViewController: BaseViewController {
    
    let mockData: [StatisticModel] = [StatisticModel(name: "Eat", icon: "eat", sum: 4444, category: .cost), StatisticModel(name: "Cinema", icon: "cinema", sum: 4444, category: .cost), StatisticModel(name: "salary", icon: "salary", sum: 4444, category: .earn)]

    var state: Category = .balance
    
    @IBOutlet weak var statisticTableView: UITableView!
    @IBOutlet var chartTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var chartView: ChartView!
    @IBOutlet weak var filterSegmentControl: SegmentControlView!
    @IBOutlet weak var dropdownImage: UIImageView!
    
    var balanceDataEntry: PieChartDataEntry?
    var earnDataEntry: PieChartDataEntry?
    var costDataEntry: PieChartDataEntry?
    
    @IBOutlet weak var chartContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        filterSegmentControl.delegate = self
        filterSegmentControl.setButtonTitiles(buttonTitiles: [Category.balance.string, Category.earn.string, Category.cost.string])
        filterSegmentControl.selectorViewColor = state.color()
        filterSegmentControl.setIndex(index: Category.allCases.firstIndex(of: state) ?? 0)
        balanceDataEntry = PieChartDataEntry(value: 4)
        earnDataEntry = PieChartDataEntry(value: 6)
        costDataEntry = PieChartDataEntry(value: 6)
        guard let balanceDataEntry = self.balanceDataEntry, let earnDataEntry = self.earnDataEntry, let costDataEntry = self.costDataEntry else { return }
        chartView.configurePieChart(colors: [Category.balance.color(), Category.earn.color(), Category.cost.color()], dataEntries: [balanceDataEntry,earnDataEntry,costDataEntry])
        
        statisticTableView.delegate = self
        statisticTableView.dataSource = self
        statisticTableView.register(StatisticCell.nib, forCellReuseIdentifier: StatisticCell.reusableIndentify)
    }
    
    @IBAction func showChartDidClick(_ sender: Any) {
        self.chartTopConstraint.constant = -1 * self.chartTopConstraint.constant - self.chartView.frame.height
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
            let pi = self.chartTopConstraint.constant < 0 ? Double.pi : 180 * -Double.pi
            self.dropdownImage.transform = CGAffineTransform(rotationAngle: CGFloat(pi))
        })
    }
    
    private func setStateColors() {
        filterSegmentControl.selectorViewColor = state.color()
    }
    private func setNavigationBarColor() {
        self.navigationController?.navigationBar.tintColor = state.color()
    }
}
//MARK: Segment delegate
extension StatisticViewController : SegmentControlDelegate {
    func changeToIndex(index: Int) {
        state = Category(rawValue: index)
        filterSegmentControl.selectorViewColor = state.color()
    }
}

extension StatisticViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension StatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticCell.reusableIndentify, for: indexPath)
        let model = mockData[indexPath.row]
        (cell as? StatisticCell)?.configure(icon: model.icon, nameCategory: model.name, sum: model.sum.description)
        return cell
    }
    
    
}
