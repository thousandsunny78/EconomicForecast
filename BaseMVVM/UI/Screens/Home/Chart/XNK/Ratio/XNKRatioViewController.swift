//
//  XNKRatioViewController.swift
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

class XNKRatioViewController: ViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    var xnkDatas: [CPIDataEntity] = []
    var timelines = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"]
    let months = ["2016", "2017", "2018", "2019", "2020", "2021"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 15.0]
    let unitsBought = [10.0, 14.0, 60.0, 13.0, 2.0, 4.0]
    private var controlList = [true, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.noDataText = "You need to provide data for the chart."
        //barChartView.chartDescription?.text = "sales vs bought "
        
        
        //legend
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        
        
        let xaxis = barChartView.xAxis
        //xaxis.valueFormatter = axisFormatDelegate
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values:self.months)
        xaxis.granularity = 1
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let yaxis = barChartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        barChartView.rightAxis.enabled = false
        barChartView.doubleTapToZoomEnabled = false
        /// quanth: ẩn phần description của biểu đồ đi
        barChartView.legend.enabled = false
        //axisFormatDelegate = self
        
        setChart()
        
    }
    
    override func makeUI() {
        super.makeUI()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? XNKRatioViewModel else { return }
        
        let input = XNKRatioViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    func setChart() {
        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<self.months.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: self.unitsSold[i])
            dataEntries.append(dataEntry)
            
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: self.self.unitsBought[i])
            dataEntries1.append(dataEntry1)
            
            //stack barchart
            //let dataEntry = BarChartDataEntry(x: Double(i), yValues:  [self.unitsSold[i],self.unitsBought[i]], label: "groupChart")
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Xuất khẩu")
        chartDataSet.colors = [UIColor.App.unemployment_male2]
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Nhập khẩu")
        chartDataSet1.colors = [UIColor.App.unemployment_female2]
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        //chartDataSet.colors = ChartColorTemplates.colorful()
        //let chartData = BarChartData(dataSet: chartDataSet)
        
        let chartData = BarChartData(dataSets: dataSets)
        
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
        
        let groupCount = self.months.count
        let startYear = 0
        
        
        chartData.barWidth = barWidth;
        barChartView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        barChartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barChartView.notifyDataSetChanged()
        
        barChartView.data = chartData
        
        //background color
        barChartView.backgroundColor = UIColor.white
        
        //chart animation
        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)

    }
}
