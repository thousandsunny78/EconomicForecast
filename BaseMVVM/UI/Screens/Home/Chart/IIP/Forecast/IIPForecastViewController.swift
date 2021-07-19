//
//  IIPForecastViewController.swift
//  BaseMVVM
//
//  Created by Quan on 17/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa
import Charts
import FittedSheets

class IIPForecastViewController: ViewController, ChartViewDelegate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var chartContentView: UIView!
    @IBOutlet weak var month1Button: UIButton!
    @IBOutlet weak var month3Button: UIButton!
    @IBOutlet weak var month6Button: UIButton!
    @IBOutlet weak var year1Button: UIButton!
    @IBOutlet weak var offButton: UIButton!
    @IBOutlet weak var month1VC: UIView!
    @IBOutlet weak var month3VC: UIView!
    @IBOutlet weak var month6VC: UIView!
    @IBOutlet weak var year1VC: UIView!
    @IBOutlet weak var offVC: UIView!
    @IBOutlet weak var forecastVC: UIView!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var detailText: UILabel!
    
    struct ForecastConstants {
        static let ITEM_PER_SCREEN: Int = 6
        static let FORECAST_1_ITEM: Int = 1
        static let FORECAST_2_ITEM: Int = 2
        static let FORECAST_3_ITEM: Int = 3
    }
    
    var iipDatas: [CPIDataEntity] = []
    var timelines = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"]
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"]
    private var controlList = [true, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    private var options = [false, false, false, false, true]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        forecastVC.isHidden = true
        /// quanth gọi trước khi vẽ biểu đồ
        drawTimeLine(size: ForecastConstants.ITEM_PER_SCREEN)
        detailText.isHidden = true
        if(!months.isEmpty){
            lineChartView.delegate = self
            drawChart()
        }
        createMenu()
        createSettingButton()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? IIPForecastViewModel else { return }
        
        let input = IIPForecastViewModel.Input()
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
        marker.chartView = lineChartView
        lineChartView.marker = marker
        
    }
    
    private func createListLineDataSet(i: Int, j: Int, isForecast: Bool,  dataSets: inout [LineChartDataSet], dataEntries: inout [ChartDataEntry], color: UIColor ){
        // Chỉ số giá tiêu dùng chung
        let dataEntry = ChartDataEntry(x: Double(i), y: iipDatas[j].value[i], data: months[i] as AnyObject)
        dataEntries.append(dataEntry)
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        chartDataSet.circleRadius = 5
        chartDataSet.circleHoleRadius = 2
        chartDataSet.drawValuesEnabled = false
        chartDataSet.highlightEnabled = true
        // set colors and enable value drawing
        chartDataSet.colors = [color]
        chartDataSet.circleColors = [color]
        
        /// quanth: nếu muốn có đường nét đứt thì dùng cái này
        if isForecast {
            chartDataSet.lineWidth = 3
            chartDataSet.lineDashLengths = [5]
        }
        
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
            // Hàng ăn và dịch vụ ăn uống
            if i < ForecastConstants.ITEM_PER_SCREEN {
                createListLineDataSet(i: i, j: j, isForecast: false, dataSets: &dataSets, dataEntries: &dataEntries, color: color)
            }
            if i > ForecastConstants.ITEM_PER_SCREEN - 2 {
                // Chỉ số giá tiêu dùng chung
                createListLineDataSet(i: i, j: j, isForecast: true, dataSets: &dataSets, dataEntries: &dataEntriesForecast, color: color)
            }
        }
    }
    
    func updateSwitch(index: Int, value: Bool){
        if(!months.isEmpty){
            controlList[index] = value
            drawChart()
        }
        
    }
    
    private func selectItem(index: Int){
        switch index {
        case 0:
            month1VC.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month1Button.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month1Button.backgroundColor = UIColor.App.tabSelected.withAlphaComponent(0.25)
            month1Button.setTitleColor(UIColor.App.tabSelected, for: .normal)
            options[0] = true
        case 1:
            month3VC.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month3Button.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month3Button.backgroundColor = UIColor.App.tabSelected.withAlphaComponent(0.25)
            month3Button.setTitleColor(UIColor.App.tabSelected, for: .normal)
            options[1] = true
        case 2:
            month6VC.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month6Button.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month6Button.backgroundColor = UIColor.App.tabSelected.withAlphaComponent(0.25)
            month6Button.setTitleColor(UIColor.App.tabSelected, for: .normal)
            options[2] = true
        case 3:
            year1VC.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            year1Button.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            year1Button.backgroundColor = UIColor.App.tabSelected.withAlphaComponent(0.25)
            year1Button.setTitleColor(UIColor.App.tabSelected, for: .normal)
            options[3] = true
        case 4:
            offVC.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            offButton.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            offButton.backgroundColor = UIColor.App.tabSelected.withAlphaComponent(0.25)
            offButton.setTitleColor(UIColor.App.tabSelected, for: .normal)
            options[4] = true
        default:
            print("do nothing")
        }
    }
    
    private func unSelectItem(index: Int){
        switch index {
        case 0:
            month1VC.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month1Button.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month1Button.backgroundColor = UIColor.white
            month1Button.setTitleColor(UIColor.App.tabSelected, for: .normal)
            options[0] = false
        case 1:
            month3VC.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month3Button.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month3Button.backgroundColor = UIColor.white
            month3Button.setTitleColor(UIColor.App.tabSelected, for: .normal)
            options[1] = false
        case 2:
            month6VC.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month6Button.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            month6Button.backgroundColor = UIColor.white
            month6Button.setTitleColor(UIColor.App.tabSelected, for: .normal)
            options[2] = false
        case 3:
            year1VC.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            year1Button.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            year1Button.backgroundColor = UIColor.white
            year1Button.setTitleColor(UIColor.App.tabSelected, for: .normal)
            options[3] = false
        case 4:
            offVC.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            offButton.roundView(borderWidth: 2.0, color: UIColor.App.tabSelected)
            offButton.backgroundColor = UIColor.white
            offButton.setTitleColor(UIColor.App.tabSelected, for: .normal)
            options[4] = false
        default:
            print("do nothing")
        }
    }
    
    private func setupMenuTapEvent(contentVC: UIView, button: UIButton, index: Int){
        //Setup tabs
        button.rx.tap.bind { [weak self] () in
            if(self?.options[index] == false && self?.months.isEmpty == false){
                for i in 0...self!.options.count{
                    if(i != index){
                        self?.unSelectItem(index: i)
                        self?.options[index] = false
                    }
                }
                self?.selectItem(index: index)
                self?.options[index] = true
                
                if (index == 1) {
                    self!.forecastVC.isHidden = false
                    /// quanth gọi trước khi vẽ biểu đồ
                    self!.drawTimeLine(size: ForecastConstants.ITEM_PER_SCREEN + ForecastConstants.FORECAST_3_ITEM)
                    self!.drawChart()
                } else {
                    self!.forecastVC.isHidden = true
                    /// quanth gọi trước khi vẽ biểu đồ
                    self!.drawTimeLine(size: ForecastConstants.ITEM_PER_SCREEN)
                    self!.drawChart()
                }
            }
        }.disposed(by: disposeBag)
    }
    
    private func createMenu(){
        unSelectItem(index: 0)
        unSelectItem(index: 1)
        unSelectItem(index: 2)
        unSelectItem(index: 3)
        selectItem(index: 4)

        setupMenuTapEvent(contentVC: month1VC, button: month1Button, index: 0)
        setupMenuTapEvent(contentVC: month3VC, button: month3Button, index: 1)
        setupMenuTapEvent(contentVC: month6VC, button: month6Button, index: 2)
        setupMenuTapEvent(contentVC: year1VC, button: year1Button, index: 3)
        setupMenuTapEvent(contentVC: offVC, button: offButton, index: 4)
    }
    
    private func createSettingButton(){
        settingButton.rx.tap.bind { [weak self] () in
            let controller = IIPBottomSheetViewController()
            controller.type = Constants.IIP_FORECAST
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
