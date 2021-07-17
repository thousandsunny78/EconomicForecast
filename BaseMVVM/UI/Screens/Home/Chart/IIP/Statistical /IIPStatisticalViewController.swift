//
//  IIPStatisticalViewController.swift
//  BaseMVVM
//
//  Created by Quan on 17/07/2021.
//  Copyright (c) 2021 quanth. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa
import Charts
import FittedSheets

class IIPStatisticalViewController: ViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var settingButton: UIButton!
    
    var iipDatas: [CPIDataEntity] = []
    var timelines = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"]
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"]
    private var controlList = [true, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        drawTimeLine(size: 6)
        drawChart()
        createSettingButton()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? IIPStatisticalViewModel else { return }
        
        let input = IIPStatisticalViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    /// quanth: bar chart
    private func drawChart(){
        barChartView.animate(yAxisDuration: 2.0)
        barChartView.chartDescription?.text = ""
        barChartView.scaleXEnabled = false
        barChartView.scaleYEnabled = false
        barChartView.highlightPerTapEnabled = true
        barChartView.dragEnabled = true
        barChartView.fitBars = true
        barChartView.drawValueAboveBarEnabled = true
        barChartView.animate(yAxisDuration: 0.5)
        barChartView.legend.enabled = false
        barChartView.legend.drawInside = true
        
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.enabled = true
        barChartView.xAxis.axisLineColor = #colorLiteral(red: 0.1215686275, green: 0.4705882353, blue: 0.7058823529, alpha: 1)
        barChartView.xAxis.granularityEnabled = false
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelCount = 12
        
        /// quanth: fix lỗi danh sách năm toàn hiển thị số
        let formatter = BarChartFormatter(values: months)
        let xAxis = XAxis()
        xAxis.valueFormatter = formatter
        barChartView.xAxis.valueFormatter = xAxis.valueFormatter
        
        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.granularity = 1
        barChartView.leftAxis.granularityEnabled = true
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.axisLineColor = #colorLiteral(red: 0.1219139919, green: 0.4706707597, blue: 0.7069483399, alpha: 1)
        
        barChartView.rightAxis.enabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        
        var result = -1
        for i in 0..<controlList.count {
            if(controlList[i] == true){
                result = i
                break
            }
        }
        if result != -1 {
            setChart(dataPoints: months, values: iipDatas[result].value)
        }
        
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]), data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
        
        var result = -1
        var color: UIColor = UIColor.App.tabUnselected
        for i in 0..<controlList.count {
            if(controlList[i] == true){
                result = i
                break
            }
        }
        if result != -1 {
            switch result {
            case 0:
                color = UIColor.red
            case 1:
                color = UIColor.blue
            case 2:
                color = UIColor.green
            case 3:
                color = UIColor.yellow
            case 4:
                color = UIColor.brown
            case 5:
                color = UIColor.purple
            case 6:
                color = UIColor.orange
            case 7:
                color = UIColor.black
            case 8:
                color = UIColor.lightGray
            case 9:
                color = UIColor.cyan
            case 10:
                color = UIColor.red
            case 11:
                color = UIColor.green
            case 12:
                color = UIColor.purple
            case 13:
                color = UIColor.yellow
            case 14:
                color = UIColor.systemBlue
            default:
                color = UIColor.App.tabUnselected
            }
        }
        
        chartDataSet.colors = [color]
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
    }
    
    func updateSwitch(index: Int, value: Bool){
        if(!months.isEmpty && value == true){
            for i in 0..<controlList.count {
                controlList[i] = false
            }
            controlList[index] = value
            drawChart()
        }
        
    }
    
    private func createSettingButton(){
        settingButton.rx.tap.bind { [weak self] () in
            let controller = IIPBottomSheetViewController()
            controller.type = Constants.CPI_STATISTICAL
            controller.iipVC = self
            controller.iipDatas = self?.iipDatas ?? []
            controller.controlList = self?.controlList ?? []
            let sheetController = SheetViewController(controller: controller)
            sheetController.topCornersRadius = 12
            sheetController.setSizes([.fixed(420), .fullScreen])
            self?.present(sheetController, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    private func drawTimeLine(size: Int){
        if(timelines.isEmpty){
            return
        }
        months = []
        for i in 0..<timelines.count{
            if(i < size){
                months.append(timelines[i])
            }
        }
    }
}
