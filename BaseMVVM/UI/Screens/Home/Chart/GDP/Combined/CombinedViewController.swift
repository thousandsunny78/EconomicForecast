//
//  CombinedViewController.swift
//  BaseMVVM
//
//  Created by Quan on 20/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa
import Charts

class CombinedViewController: ViewController, ChartViewDelegate {
    
    @IBOutlet weak var combinedChartView: CombinedChartView!
    @IBOutlet weak var detailText: UILabel!
    private var timelines: [String] = ["2015", "2016", "2017", "2018", "2019", "2020"]
    
    let months = ["2015", "2016", "2017", "2018", "2019", "2020"]
    let unitsSold = [200.0, 50.0, 600.0, 120.0, 240.0, 160.0]
    let unitsBought = [2.0, 4.0, 6.0, 3.0, 12.0, 16.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        detailText.isHidden = true
        combinedChartView.delegate = self
        convertCombines(dataEntryX: months, dataEntryY:  unitsSold, dataEntryZ: unitsBought)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? CombinedViewModel else { return }
        
        let input = CombinedViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    func convertCombines(dataEntryX forX:[String],dataEntryY forY: [Double], dataEntryZ forZ: [Double]) {


        var dataEntries: [BarChartDataEntry] = []
        var dataEntrieszor: [ChartDataEntry] = [ChartDataEntry]()

        for (i, v) in forY.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(i), y: v, data: forX as AnyObject?)
            dataEntrieszor.append(dataEntry)
        }

        for (i, v) in forZ.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(i), y: v, data: forX as AnyObject?)
            dataEntries.append(dataEntry)
        }

        /// quanth: setup giao diện biểu đồ đường
        let lineChartSet = LineChartDataSet(entries: dataEntrieszor, label: "Line Data")
        lineChartSet.circleRadius = 5
        lineChartSet.circleHoleRadius = 2
        lineChartSet.drawValuesEnabled = false
        lineChartSet.highlightEnabled = true
        // set colors and enable value drawing
        lineChartSet.colors = [UIColor.orange]
        lineChartSet.circleColors = [UIColor.orange]
        let lineChartData = LineChartData(dataSets: [lineChartSet])

        /// quanth: setup giao diện biểu đồ cột
        let barChartSet = BarChartDataSet(entries: dataEntries, label: "Bar Data")
        // set colors and enable value drawing
        barChartSet.colors = [UIColor.App.unemployment_male]
        let barChartData = BarChartData(dataSets: [barChartSet])

        /// quanth: cho 2 cột hiện 2 giá trị khác nhau
        lineChartSet.axisDependency = .left
        barChartSet.axisDependency = .right

        let comData = CombinedChartData(dataSets: [lineChartSet,barChartSet])
        comData.barData = barChartData
        comData.lineData = lineChartData

        combinedChartView.data = comData
        combinedChartView.notifyDataSetChanged()

        combinedChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        combinedChartView.xAxis.granularity = 1
        
        combinedChartView.doubleTapToZoomEnabled = false
        combinedChartView.pinchZoomEnabled = false
        combinedChartView.xAxis.labelPosition = .bottom
        
        
        combinedChartView.xAxis.drawAxisLineEnabled = false
        combinedChartView.xAxis.drawGridLinesEnabled = false
        combinedChartView.rightAxis.drawGridLinesEnabled = false
//        combinedChartView.leftAxis.drawGridLinesEnabled = false
        combinedChartView.rightAxis.drawGridLinesEnabled = false
//        combinedChartView.leftAxis.drawAxisLineEnabled = false
//        combinedChartView.xAxis.drawGridLinesEnabled = false
//        combinedChartView.leftAxis.drawLabelsEnabled = false
        /// quanth: ẩn phần description của biểu đồ đi
        combinedChartView.legend.enabled = false
        
        combinedChartView.xAxis.spaceMin = 0.5
        combinedChartView.xAxis.spaceMax = 0.5
        
        // quanth: bấm vào point sẽ hiện thông tin
        let marker = BalloonMarker()
        /// quanth: cho value sẽ hiện lên trên top của chart
        var height = self.combinedChartView.frame.size.height
        marker.parentHeight = height
        marker.chartView = combinedChartView
        combinedChartView.marker = marker

        combinedChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .easeInCirc)


    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        detailText.isHidden = false
        let fullText = timelines[Int(highlight.x)]
        let fullNameArr = String(fullText).components(separatedBy: "-")
        let text = "năm \(fullText)"
        detailText.text = text
        print("chartValueSelected : x = \(highlight.x)")
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        detailText.isHidden = true
        print("chartValueNothingSelected")
    }
}
