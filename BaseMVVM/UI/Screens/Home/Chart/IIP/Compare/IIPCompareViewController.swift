//
//  IIPCompareViewController.swift
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
import FittedSheets

class IIPCompareViewController: ViewController, ChartViewDelegate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var chartContentView: UIView!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var detailText: UILabel!
    
    struct CompareConstants {
        static let ITEM_PER_SCREEN: Int = 6
    }
    
    var iipDatas: [CPIDataEntity] = []
    var timelines = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"]
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"]
    private var controlList = [true, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        /// quanth gọi trước khi vẽ biểu đồ
        drawTimeLine(size: CompareConstants.ITEM_PER_SCREEN)
        detailText.isHidden = true
        if(!months.isEmpty){
            lineChartView.delegate = self
            drawChart()
        }
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? IIPCompareViewModel else { return }
        
        let input = IIPCompareViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    private func drawChart() {
        var dataEntries0: [ChartDataEntry] = []
        var dataEntries0A: [ChartDataEntry] = []
        var dataEntries1: [ChartDataEntry] = []
        var dataEntries1A: [ChartDataEntry] = []
        var dataEntries2: [ChartDataEntry] = []
        var dataEntries2A: [ChartDataEntry] = []
        var dataEntries3: [ChartDataEntry] = []
        var dataEntries3A: [ChartDataEntry] = []
        var dataEntries4: [ChartDataEntry] = []
        var dataEntries4A: [ChartDataEntry] = []
        var dataEntries5: [ChartDataEntry] = []
        var dataEntries5A: [ChartDataEntry] = []
        var dataEntries6: [ChartDataEntry] = []
        var dataEntries6A: [ChartDataEntry] = []
        var dataEntries7: [ChartDataEntry] = []
        var dataEntries7A: [ChartDataEntry] = []
        var dataEntries8: [ChartDataEntry] = []
        var dataEntries8A: [ChartDataEntry] = []
        var dataEntries9: [ChartDataEntry] = []
        var dataEntries9A: [ChartDataEntry] = []
        var dataEntries10: [ChartDataEntry] = []
        var dataEntries10A: [ChartDataEntry] = []
        var dataEntries11: [ChartDataEntry] = []
        var dataEntries11A: [ChartDataEntry] = []
        var dataEntries12: [ChartDataEntry] = []
        var dataEntries12A: [ChartDataEntry] = []
        var dataEntries13: [ChartDataEntry] = []
        var dataEntries13A: [ChartDataEntry] = []
        var dataEntries14: [ChartDataEntry] = []
        var dataEntries14A: [ChartDataEntry] = []
    
        var dataSets: [LineChartDataSet] = []
        
        // quanth: tạo entries
        for i in 0..<months.count {
            for j in 0..<controlList.count {
                switch j {
                case 0:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries0, dataEntriesForecast: &dataEntries0A, color: UIColor.red)
                case 1:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries1, dataEntriesForecast: &dataEntries1A, color: UIColor.blue)
                    
                case 2:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries2, dataEntriesForecast: &dataEntries2A, color: UIColor.green)
                    
                case 3:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries3, dataEntriesForecast: &dataEntries3A, color: UIColor.yellow)
                    
                case 4:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries4, dataEntriesForecast: &dataEntries4A, color: UIColor.brown)
                    
                case 5:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries5, dataEntriesForecast: &dataEntries5A, color: UIColor.purple)
                    
                case 6:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries6, dataEntriesForecast: &dataEntries6A, color: UIColor.orange)
                    
                case 7:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries7, dataEntriesForecast: &dataEntries7A, color: UIColor.black)
                    
                case 8:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries8, dataEntriesForecast: &dataEntries8A, color: UIColor.gray)
                    
                case 9:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries9, dataEntriesForecast: &dataEntries9A, color: UIColor.cyan)
                     
                case 10:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries10, dataEntriesForecast: &dataEntries10A, color: UIColor.orange)
                    
                case 11:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries11, dataEntriesForecast: &dataEntries11A, color: UIColor.green)
                    
                case 12:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries12, dataEntriesForecast: &dataEntries12A, color: UIColor.purple)
                    
                case 13:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries13, dataEntriesForecast: &dataEntries13A, color: UIColor.yellow)
                    
                case 14:
                    handleCheckinShow(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries14, dataEntriesForecast: &dataEntries14A, color: UIColor.systemBlue)
                    
                default:
                    print("Have you done something new?")
                }
            }
        }
        
        let chartData = LineChartData(dataSets: dataSets)
        lineChartView.data = chartData

        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChartView.xAxis.setLabelCount(months.count, force: true)
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true

        lineChartView.rightAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false

        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.legend.enabled = false
        
        /// quanth: cho margin left 1 đoạn
        lineChartView.xAxis.spaceMin = 0.03
        lineChartView.xAxis.spaceMax = 0.25
        
        // quanth: bấm vào point sẽ hiện thông tin
        let marker = BalloonMarker()
        //let marker = PillMarker(color: UIColor.red, font: UIFont.boldSystemFont(ofSize: 14), textColor: UIColor.red)
        /// quanth: cho value sẽ hiện lên trên top của chart
        var height = self.lineChartView.frame.size.height
        marker.parentHeight = height
        marker.chartView = lineChartView
        lineChartView.marker = marker
        
    }
    
    private func createListLineDataSet(i: Int, j: Int, dataSets: inout [LineChartDataSet], dataEntries: inout [ChartDataEntry], color: UIColor ){
        // Chỉ số giá tiêu dùng chung
        let dataEntry = ChartDataEntry(x: Double(i), y: iipDatas[j].value[i], data: months[i] as AnyObject)
        dataEntries.append(dataEntry)
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: iipDatas[j].name)
        chartDataSet.circleRadius = 5
        chartDataSet.circleHoleRadius = 2
        chartDataSet.drawValuesEnabled = false
        chartDataSet.highlightEnabled = true
        // set colors and enable value drawing
        chartDataSet.colors = [UIColor.App.unemployment_male]
        chartDataSet.circleColors = [UIColor.App.unemployment_male]
        
        dataSets.append(chartDataSet)
    }
    
    private func createListCompareLineDataSet(i: Int, j: Int, dataSets: inout [LineChartDataSet], dataEntries: inout [ChartDataEntry], color: UIColor ){
        // Chỉ số giá tiêu dùng chung
        let dataEntry = ChartDataEntry(x: Double(i), y: (iipDatas[j].value[i] + Double(i+1)), data: months[i] as AnyObject)
        dataEntries.append(dataEntry)
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Cả nước")
        chartDataSet.circleRadius = 5
        chartDataSet.circleHoleRadius = 2
        chartDataSet.drawValuesEnabled = false
        chartDataSet.highlightEnabled = true
        // set colors and enable value drawing
        chartDataSet.colors = [UIColor.App.unemployment_female]
        chartDataSet.circleColors = [UIColor.App.unemployment_female]
        
        /// quanth: nếu muốn có đường nét đứt thì dùng cái này
        chartDataSet.lineWidth = 3
        chartDataSet.lineDashLengths = [5]
        
        dataSets.append(chartDataSet)
    }
    
    private func handleCheckinShow(
        i: Int,
        j: Int,
        dataSets: inout [LineChartDataSet],
        dataEntries: inout [ChartDataEntry],
        dataEntriesForecast: inout [ChartDataEntry],
        color: UIColor ){
        
        if(controlList[j]){
            // Hiện tại
            createListLineDataSet(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntries, color: color)
            // Cả nước
            createListCompareLineDataSet(i: i, j: j, dataSets: &dataSets, dataEntries: &dataEntriesForecast, color: color)
        }
    }
    
    func updateSwitch(index: Int, value: Bool){
        if(!months.isEmpty){
            controlList[index] = value
            drawChart()
        }
        
    }
    
    private func createSettingButton(){
        settingButton.rx.tap.bind { [weak self] () in
            let controller = CPIBottomSheetViewController()
            controller.type = Constants.CPI_FORECAST
            controller.cpiVC = self
            controller.cpiDatas = self?.iipDatas ?? []
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
                if(i % 2 == 1) {
                    months.append("")
                } else {
                    months.append(timelines[i])
                }
            }
        }
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        detailText.isHidden = false
        let fullText = timelines[Int(highlight.x)]
        let fullNameArr = String(fullText).components(separatedBy: "-")
        let monthVal = fullNameArr[1]
        let yearVal = fullNameArr[0]
        let text = "Tháng \(monthVal) năm \(yearVal)"
        detailText.text = text
        print("chartValueSelected : x = \(highlight.x)")
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        detailText.isHidden = true
        print("chartValueNothingSelected")
    }
}
