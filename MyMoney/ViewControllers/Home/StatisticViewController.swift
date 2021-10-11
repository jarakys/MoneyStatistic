//
//  StatisticViewController.swift
//  MyMoney
//
//  Created by Kirill on 05.03.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit
import Charts
import CoreData

class StatisticViewController: BaseViewController {
    
    @IBOutlet private weak var statisticTableView: UITableView!
    @IBOutlet private var chartTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var chartView: ChartView!
    @IBOutlet private weak var filterSegmentControl: SegmentControlView!
    @IBOutlet private weak var dropdownImage: UIImageView!
    @IBOutlet private weak var chartContainerView: UIView!
    
    private var balanceDataEntry: PieChartDataEntry?
    private var earnDataEntry: PieChartDataEntry?
    private var costDataEntry: PieChartDataEntry?
    
    private lazy var reports: NSFetchedResultsController<Reports> = {
        DatabaseManager.shared.getReportsFetchController()
    }()
    
    public var state: Category = .balance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reports.delegate = self
        filterSegmentControl.delegate = self
        filterSegmentControl.setButtonTitiles(buttonTitiles: [Category.balance.string, Category.earn.string, Category.cost.string])
        filterSegmentControl.selectorViewColor = state.color()
        filterSegmentControl.setIndex(index: Category.allCases.firstIndex(of: state) ?? 0)
        updateChart()
        statisticTableView.delegate = self
        statisticTableView.dataSource = self
        statisticTableView.register(StatisticCell.nib, forCellReuseIdentifier: StatisticCell.reusableIndentify)
    }
    
    private func updateChart() {
        balanceDataEntry = PieChartDataEntry(value: Double(DatabaseManager.shared.getBalance()))
        earnDataEntry = PieChartDataEntry(value: Double(DatabaseManager.shared.getEarn()))
        costDataEntry = PieChartDataEntry(value: Double(DatabaseManager.shared.getSpent()))
        guard let balanceDataEntry = self.balanceDataEntry, let earnDataEntry = self.earnDataEntry, let costDataEntry = self.costDataEntry else { return }
        chartView.configurePieChart(colors: [Category.balance.color(), Category.earn.color(), Category.cost.color()], dataEntries: [balanceDataEntry,earnDataEntry,costDataEntry])
    }
    
    private func setStateColors() {
        filterSegmentControl.selectorViewColor = state.color()
    }
    
    private func setNavigationBarColor() {
        self.navigationController?.navigationBar.tintColor = state.color()
    }
    
    @IBAction private func showChartDidClick(_ sender: Any) {
        self.chartTopConstraint.constant = -1 * self.chartTopConstraint.constant - self.chartView.frame.height
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
            let pi = self.chartTopConstraint.constant < 0 ? Double.pi : 180 * -Double.pi
            self.dropdownImage.transform = CGAffineTransform(rotationAngle: CGFloat(pi))
        })
    }
}

// MARK: Segment delegate
extension StatisticViewController : SegmentControlDelegate {
    func changeToIndex(index: Int) {
        state = Category(rawValue: index)
        filterSegmentControl.selectorViewColor = state.color()
        reports.fetchRequest.predicate = NSPredicate(format: "category.mainCategory == %@", NSNumber(value: state.rawValue))
        try? reports.performFetch()
        statisticTableView.reloadData()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension StatisticViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reports.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticCell.reusableIndentify, for: indexPath)
        let model = reports.fetchedObjects?[indexPath.row]
        (cell as? StatisticCell)?.configure(for: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: NSFetchedResultsControllerDelegate
extension StatisticViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        statisticTableView.reloadData()
    }
}
