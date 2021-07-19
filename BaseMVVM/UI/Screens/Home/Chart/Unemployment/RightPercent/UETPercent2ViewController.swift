//
//  UETPercent2ViewController.swift
//  BaseMVVM
//
//  Created by Quan on 19/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa
import Charts

class UETPercent2ViewController: ViewController {
    
    // MARK: View lifecycle
    @IBOutlet weak var pieChartView: PieChartView!
    
    var chartTitle: String? = ""
    var items = ["Nam", "Nữ"]
    var values = [45.0, 55.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChart(dataPoints: items, values: values)
    }
    
    override func makeUI() {
        super.makeUI()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? UETPercent2ViewModel else { return }
        
        let input = UETPercent2ViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
            //ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .percent
        format.maximumFractionDigits = 1
        format.multiplier = 1.0
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        pieChartDataSet.colors = [UIColor.App.unemployment_male, UIColor.App.unemployment_female]
        pieChartView.holeColor = UIColor.white
        //  pieChartView.holeRadiusPercent = 0.95
        pieChartView.centerText = self.chartTitle
        pieChartView.usePercentValuesEnabled = true
        pieChartView.animate(yAxisDuration: 2.0, easingOption: .easeInOutBack)
        pieChartView.data = pieChartData
    }
}
