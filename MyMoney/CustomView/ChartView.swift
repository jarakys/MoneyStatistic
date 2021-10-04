//
//  ChartView.swift
//  MyMoney
//
//  Created by Kirill on 24.06.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit
import Charts

protocol ChartViewDelegate: class {
    func didTap()
}

class ChartView: UIView {
    
    let nibName = "ChartView"
    var contentView: UIView?
    
    public var dataEntries = [PieChartDataEntry]()
    public var colors = [UIColor]()
    
    var delegate: ChartViewDelegate?
    
    public var tapGesture: UIGestureRecognizer = UITapGestureRecognizer()
    
    private var charDataSet: PieChartDataSet?

    @IBOutlet var pieChart: PieChartView!
    
    
    
//    public func setColor()
    
    func updateChart(dataEntries: [PieChartDataEntry]) {
//        let charDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        configurePieChart(colors: self.colors, dataEntries: dataEntries)
    }
    
    func configurePieChart(colors: [UIColor], dataEntries: [PieChartDataEntry]) {
        charDataSet = PieChartDataSet(entries: dataEntries, label: "")
        let chartData = PieChartData(dataSet: charDataSet!)
        charDataSet?.colors = colors
        charDataSet?.drawValuesEnabled = true
        charDataSet?.valueLinePart1OffsetPercentage = 0.5;
        charDataSet?.valueLinePart1Length = 0.1;
        charDataSet?.valueLinePart2Length = 0.2;
        charDataSet?.yValuePosition = .outsideSlice
        chartData.setValueTextColor(.systemOrange)
        pieChart.data = chartData
        chartData.setValueFormatter(DefaultValueFormatter(decimals: 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        contentView?.backgroundColor = .systemBackground
        
        pieChart.drawSlicesUnderHoleEnabled = false
        pieChart.drawEntryLabelsEnabled = false
        pieChart.holeRadiusPercent = 0.8
        pieChart.holeColor = UIColor.systemBackground
        pieChart.legend.enabled = false
        
        pieChart.backgroundColor = .systemBackground
        tapGesture.addTarget(self, action: #selector(chartClick(_:)))
        pieChart.addGestureRecognizer(tapGesture)
        pieChart.drawMarkers = false
        pieChart.usePercentValuesEnabled = true
        pieChart.layer.masksToBounds = true
        pieChart.layer.cornerRadius = 10
        pieChart.rotationEnabled = false
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @objc func chartClick(_ sender: Any) {
        delegate?.didTap()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
