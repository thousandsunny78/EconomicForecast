//
//  CPIViewController.swift
//  BaseMVVM
//
//  Created by Quan on 12/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa
import Charts

class CPIViewController: ViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var chartContentView: UIView!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var areaVC1: UIView!
    @IBOutlet weak var areaVC2: UIView!
    @IBOutlet weak var areaVC3: UIView!
    @IBOutlet weak var areaVC4: UIView!
    @IBOutlet weak var areaVC5: UIView!
    @IBOutlet weak var areaVC6: UIView!
    @IBOutlet weak var areaVC7: UIView!
    @IBOutlet weak var areaVC8: UIView!
    @IBOutlet weak var areaVC9: UIView!
    @IBOutlet weak var areaVC10: UIView!
    @IBOutlet weak var areaVC11: UIView!
    @IBOutlet weak var areaVC12: UIView!
    @IBOutlet weak var areaVC13: UIView!
    @IBOutlet weak var areaVC14: UIView!
    @IBOutlet weak var areaVC15: UIView!
    // MARK: View lifecycle
    
    private var cpiDatas: [DataEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        // quanth: showLoading
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator?.labelText = "Đang tải..."
        Indicator?.isUserInteractionEnabled = false
        Indicator?.show(true)
        
        addChartShadow(cornerRadius: 12.0, shadowRadius: 5.0)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? CPIViewModel else { return }
        
        let input = CPIViewModel.Input()
        let output = viewModel.transform(input: input)
        
        // subcribe postal subject
        output.cpiDataSubject.subscribe(onNext: {[weak self] cpiData in
            guard let self = self else { return }
            if(!cpiData.isEmpty){
                self.cpiDatas = cpiData
                self.drawChart()
                self.drawControllBoard()
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.fetchCPIIndexs()
    }
    
    // Show list data
    private func drawControllBoard() {
        createControlList(areaVC: areaVC1, entity: ChartControlEntity(color: UIColor.red, content: cpiDatas[0].name, isOn: true, index: 0)!)
        createControlList(areaVC: areaVC2, entity: ChartControlEntity(color: UIColor.blue, content: cpiDatas[1].name, isOn: false, index: 1)!)
        createControlList(areaVC: areaVC3, entity: ChartControlEntity(color: UIColor.green, content: cpiDatas[2].name, isOn: false, index: 2)!)
        createControlList(areaVC: areaVC4, entity: ChartControlEntity(color: UIColor.yellow, content: cpiDatas[3].name, isOn: false, index: 3)!)
        createControlList(areaVC: areaVC5, entity: ChartControlEntity(color: UIColor.brown, content: cpiDatas[4].name, isOn: false, index: 4)!)
        createControlList(areaVC: areaVC6, entity: ChartControlEntity(color: UIColor.purple, content: cpiDatas[5].name, isOn: false, index: 5)!)
        createControlList(areaVC: areaVC7, entity: ChartControlEntity(color: UIColor.orange, content: cpiDatas[6].name, isOn: false, index: 6)!)
        createControlList(areaVC: areaVC8, entity: ChartControlEntity(color: UIColor.black, content: cpiDatas[7].name, isOn: false, index: 7)!)
        createControlList(areaVC: areaVC9, entity: ChartControlEntity(color: UIColor.lightGray, content: cpiDatas[8].name, isOn: false, index: 8)!)
        createControlList(areaVC: areaVC10, entity: ChartControlEntity(color: UIColor.cyan, content: cpiDatas[9].name, isOn: false, index: 9)!)
        createControlList(areaVC: areaVC11, entity: ChartControlEntity(color: UIColor.red, content: cpiDatas[10].name, isOn: false, index: 10)!)
        createControlList(areaVC: areaVC12, entity: ChartControlEntity(color: UIColor.green, content: cpiDatas[11].name, isOn: false, index: 11)!)
        createControlList(areaVC: areaVC13, entity: ChartControlEntity(color: UIColor.purple, content: cpiDatas[12].name, isOn: false, index: 12)!)
        createControlList(areaVC: areaVC14, entity: ChartControlEntity(color: UIColor.yellow, content: cpiDatas[13].name, isOn: false, index: 13)!)
        createControlList(areaVC: areaVC15, entity: ChartControlEntity(color: UIColor.systemBlue, content: cpiDatas[14].name, isOn: false, index: 14)!)
    }
    
    private func createControlList(areaVC: UIView!, entity: ChartControlEntity){
        let controllBoardVC: ViewController = {
            let vc = CPIItemViewController(nibName: CPIItemViewController.className, bundle: nil)
            let navigator = CPIItemNavigator(with: vc)
            let viewModel = CPIItemViewModel(navigator: navigator)
            vc.viewModel = viewModel
            vc.entity = entity
            vc.cpiVC = self
            return vc
        }()
        
        addChildViewController(controllBoardVC, toContainerView: areaVC)
        
    }
    
    private func drawChart() {
        var dataEntries0: [ChartDataEntry] = []
        var dataEntries1: [ChartDataEntry] = []
        var dataEntries2: [ChartDataEntry] = []
        var dataEntries3: [ChartDataEntry] = []
        var dataEntries4: [ChartDataEntry] = []
        var dataEntries5: [ChartDataEntry] = []
        var dataEntries6: [ChartDataEntry] = []
        var dataEntries7: [ChartDataEntry] = []
        var dataEntries8: [ChartDataEntry] = []
        var dataEntries9: [ChartDataEntry] = []
        var dataEntries10: [ChartDataEntry] = []
        var dataEntries11: [ChartDataEntry] = []
        var dataEntries12: [ChartDataEntry] = []
        var dataEntries13: [ChartDataEntry] = []
        var dataEntries14: [ChartDataEntry] = []
    
        var dataSets: [LineChartDataSet] = []
        
        // quanth: tạo entries
        for i in 0..<months.count {
            for j in 0..<controlList.count {
                switch j {
                case 0:
                    if(controlList[j]){
                        // Chỉ số giá tiêu dùng chung
                        let dataEntry0 = ChartDataEntry(x: Double(i), y: cpiDatas[0].value[i], data: months[i] as AnyObject)
                        dataEntries0.append(dataEntry0)
                        
                        let chartDataSet0 = LineChartDataSet(entries: dataEntries0, label: nil)
                        chartDataSet0.circleRadius = 5
                        chartDataSet0.circleHoleRadius = 2
                        chartDataSet0.drawValuesEnabled = false
                        chartDataSet0.highlightEnabled = true
                        // set colors and enable value drawing
                        chartDataSet0.colors = [UIColor.red]
                        chartDataSet0.circleColors = [UIColor.red]
                        
                        /// quanth: nếu muốn có đường nét đứt thì dùng cái này
                        // chartDataSet0.lineWidth = 3
                        // chartDataSet0.lineDashLengths = [5]
                        dataSets.append(chartDataSet0)
                    }
                case 1:
                    if(controlList[j]){
                        // Hàng ăn và dịch vụ ăn uống
                        let dataEntry1 = ChartDataEntry(x: Double(i), y: cpiDatas[1].value[i], data: months[i] as AnyObject)
                        dataEntries1.append(dataEntry1)
                        
                        let chartDataSet1 = LineChartDataSet(entries: dataEntries1, label: nil)
                        chartDataSet1.circleRadius = 5
                        chartDataSet1.circleHoleRadius = 2
                        chartDataSet1.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet1.colors = [UIColor.blue]
                            chartDataSet1.circleColors = [UIColor.blue]
                        dataSets.append(chartDataSet1)
                    }
                    
                case 2:
                    if(controlList[j]){
                        // Lương thực
                        let dataEntry2 = ChartDataEntry(x: Double(i), y: cpiDatas[2].value[i], data: months[i] as AnyObject)
                        dataEntries2.append(dataEntry2)
                        
                        let chartDataSet2 = LineChartDataSet(entries: dataEntries2, label: nil)
                        chartDataSet2.circleRadius = 5
                        chartDataSet2.circleHoleRadius = 2
                        chartDataSet2.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet2.colors = [UIColor.green]
                        chartDataSet2.circleColors = [UIColor.green]
                        dataSets.append(chartDataSet2)
                    }
                    
                case 3:
                    if(controlList[j]){
                        // Thực phẩm
                        let dataEntry3 = ChartDataEntry(x: Double(i), y: cpiDatas[3].value[i], data: months[i] as AnyObject)
                        dataEntries3.append(dataEntry3)
                        
                        let chartDataSet3 = LineChartDataSet(entries: dataEntries3, label: nil)
                        chartDataSet3.circleRadius = 5
                        chartDataSet3.circleHoleRadius = 2
                        chartDataSet3.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet3.colors = [UIColor.yellow]
                        chartDataSet3.circleColors = [UIColor.yellow]
                        dataSets.append(chartDataSet3)
                    }
                    
                case 4:
                    if(controlList[j]){
                        // Ăn uống ngoài gia đình
                        let dataEntry4 = ChartDataEntry(x: Double(i), y: cpiDatas[4].value[i], data: months[i] as AnyObject)
                        dataEntries4.append(dataEntry4)
                        
                        let chartDataSet4 = LineChartDataSet(entries: dataEntries4, label: nil)
                        chartDataSet4.circleRadius = 5
                        chartDataSet4.circleHoleRadius = 2
                        chartDataSet4.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet4.colors = [UIColor.brown]
                            chartDataSet4.circleColors = [UIColor.brown]
                        dataSets.append(chartDataSet4)
                    }
                    
                case 5:
                    if(controlList[j]){
                        // Đồ uống và thuốc lá
                        let dataEntry5 = ChartDataEntry(x: Double(i), y: cpiDatas[5].value[i], data: months[i] as AnyObject)
                        dataEntries5.append(dataEntry5)
                        
                        let chartDataSet5 = LineChartDataSet(entries: dataEntries5, label: nil)
                        chartDataSet5.circleRadius = 5
                        chartDataSet5.circleHoleRadius = 2
                        chartDataSet5.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet5.colors = [UIColor.purple]
                            chartDataSet5.circleColors = [UIColor.purple]
                        dataSets.append(chartDataSet5)
                    }
                    
                case 6:
                    if(controlList[j]){
                        // Chỉ số giá tiêu dùng chung
                        let dataEntry6 = ChartDataEntry(x: Double(i), y: cpiDatas[6].value[i], data: months[i] as AnyObject)
                        dataEntries6.append(dataEntry6)
                        
                        let chartDataSet6 = LineChartDataSet(entries: dataEntries6, label: nil)
                        chartDataSet6.circleRadius = 5
                        chartDataSet6.circleHoleRadius = 2
                        chartDataSet6.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet6.colors = [UIColor.orange]
                            chartDataSet6.circleColors = [UIColor.orange]
                        dataSets.append(chartDataSet6)
                    }
                    
                case 7:
                    if(controlList[j]){
                        // Hàng ăn và dịch vụ ăn uống
                        let dataEntry7 = ChartDataEntry(x: Double(i), y: cpiDatas[7].value[i], data: months[i] as AnyObject)
                        dataEntries7.append(dataEntry7)
                        
                        let chartDataSet7 = LineChartDataSet(entries: dataEntries7, label: nil)
                        chartDataSet7.circleRadius = 5
                        chartDataSet7.circleHoleRadius = 2
                        chartDataSet7.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet7.colors = [UIColor.black]
                            chartDataSet7.circleColors = [UIColor.black]
                        dataSets.append(chartDataSet7)
                    }
                    
                case 8:
                    if(controlList[j]){
                        // Lương thực
                        let dataEntry8 = ChartDataEntry(x: Double(i), y: cpiDatas[8].value[i], data: months[i] as AnyObject)
                        dataEntries8.append(dataEntry8)
                        
                        let chartDataSet8 = LineChartDataSet(entries: dataEntries8, label: nil)
                        chartDataSet8.circleRadius = 5
                        chartDataSet8.circleHoleRadius = 2
                        chartDataSet8.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet8.colors = [UIColor.lightGray]
                            chartDataSet8.circleColors = [UIColor.lightGray]
                        dataSets.append(chartDataSet8)
                    }
                    
                case 9:
                    if(controlList[j]){
                        // Thực phẩm
                        let dataEntry9 = ChartDataEntry(x: Double(i), y: cpiDatas[9].value[i], data: months[i] as AnyObject)
                        dataEntries9.append(dataEntry9)
                        
                        let chartDataSet9 = LineChartDataSet(entries: dataEntries9, label: nil)
                        chartDataSet9.circleRadius = 5
                        chartDataSet9.circleHoleRadius = 2
                        chartDataSet9.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet9.colors = [UIColor.cyan]
                            chartDataSet9.circleColors = [UIColor.cyan]
                        dataSets.append(chartDataSet9)
                    }
                     
                case 10:
                    if(controlList[j]){
                        // Ăn uống ngoài gia đình
                        let dataEntry10 = ChartDataEntry(x: Double(i), y: cpiDatas[10].value[i], data: months[i] as AnyObject)
                        dataEntries10.append(dataEntry10)
                        
                        let chartDataSet10 = LineChartDataSet(entries: dataEntries10, label: nil)
                        chartDataSet10.circleRadius = 5
                        chartDataSet10.circleHoleRadius = 2
                        chartDataSet10.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet10.colors = [UIColor.red]
                            chartDataSet10.circleColors = [UIColor.red]
                        dataSets.append(chartDataSet10)
                    }
                    
                case 11:
                    if(controlList[j]){
                        // Hàng ăn và dịch vụ ăn uống
                        let dataEntry11 = ChartDataEntry(x: Double(i), y: cpiDatas[11].value[i], data: months[i] as AnyObject)
                        dataEntries11.append(dataEntry11)
                        
                        let chartDataSet11 = LineChartDataSet(entries: dataEntries11, label: nil)
                        chartDataSet11.circleRadius = 5
                        chartDataSet11.circleHoleRadius = 2
                        chartDataSet11.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet11.colors = [UIColor.green]
                            chartDataSet11.circleColors = [UIColor.green]
                        dataSets.append(chartDataSet11)
                    }
                    
                case 12:
                    if(controlList[j]){
                        // Lương thực
                        let dataEntry12 = ChartDataEntry(x: Double(i), y: cpiDatas[12].value[i], data: months[i] as AnyObject)
                        dataEntries12.append(dataEntry12)
                        
                        let chartDataSet12 = LineChartDataSet(entries: dataEntries12, label: nil)
                        chartDataSet12.circleRadius = 5
                        chartDataSet12.circleHoleRadius = 2
                        chartDataSet12.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet12.colors = [UIColor.purple]
                            chartDataSet12.circleColors = [UIColor.purple]
                        dataSets.append(chartDataSet12)
                    }
                    
                case 13:
                    if(controlList[j]){
                        // Thực phẩm
                        let dataEntry13 = ChartDataEntry(x: Double(i), y: cpiDatas[13].value[i], data: months[i] as AnyObject)
                        dataEntries13.append(dataEntry13)
                        
                        let chartDataSet13 = LineChartDataSet(entries: dataEntries13, label: nil)
                        chartDataSet13.circleRadius = 5
                        chartDataSet13.circleHoleRadius = 2
                        chartDataSet13.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet13.colors = [UIColor.yellow]
                            chartDataSet13.circleColors = [UIColor.yellow]
                        dataSets.append(chartDataSet13)
                    }
                    
                case 14:
                    if(controlList[j]){
                        // Ăn uống ngoài gia đình
                        let dataEntry14 = ChartDataEntry(x: Double(i), y: cpiDatas[14].value[i], data: months[i] as AnyObject)
                        dataEntries14.append(dataEntry14)
                        
                        let chartDataSet14 = LineChartDataSet(entries: dataEntries14, label: nil)
                        chartDataSet14.circleRadius = 5
                        chartDataSet14.circleHoleRadius = 2
                        chartDataSet14.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet14.colors = [UIColor.systemBlue]
                        chartDataSet14.circleColors = [UIColor.systemBlue]
                        dataSets.append(chartDataSet14)
                    }
                    
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
        
        // quanth: bấm vào point sẽ hiện thông tin
        let marker = BalloonMarker()
        marker.chartView = lineChartView
        lineChartView.marker = marker
        
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    // quanth: round and shadow uiview
    private func addChartShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        lineChartView.layer.cornerRadius = cornerRadius
        lineChartView.layer.masksToBounds = true

        chartContentView.layer.cornerRadius = cornerRadius
        chartContentView.layer.masksToBounds = false

        chartContentView.layer.shadowColor = UIColor.black.cgColor
        chartContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        chartContentView.layer.shadowOpacity = 0.2
        chartContentView.layer.shadowRadius = shadowRadius

        lineChartView.frame = lineChartView.bounds
        lineChartView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
    
    func updateSwitch(index: Int, value: Bool){
        controlList[index] = value
        drawChart()
    }
    
    private var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    private var controlList = [true, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    
}
