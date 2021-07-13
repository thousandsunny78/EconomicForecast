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
    @IBOutlet weak var controlContent: UIView!
    @IBOutlet weak var control: UIView!
    @IBOutlet weak var lineChartContentView: UIView!
    @IBOutlet weak var aSwitch: UISwitch!
    @IBOutlet weak var bSwitch: UISwitch!
    @IBOutlet weak var cSwitch: UISwitch!
    @IBOutlet weak var eSwitch: UISwitch!
    @IBOutlet weak var fSwitch: UISwitch!
    @IBOutlet weak var gSwitch: UISwitch!
    @IBOutlet weak var hSwitch: UISwitch!
    @IBOutlet weak var iSwitch: UISwitch!
    @IBOutlet weak var kSwitch: UISwitch!
    @IBOutlet weak var lSwitch: UISwitch!
    @IBOutlet weak var mSwitch: UISwitch!
    @IBOutlet weak var nSwitch: UISwitch!
    @IBOutlet weak var oSwitch: UISwitch!
    @IBOutlet weak var pSwitch: UISwitch!
    @IBOutlet weak var qSwitch: UISwitch!
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        setChart()
        resizeSwitch()
        setupSwitch()
        //addCtrlShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addChartShadow(cornerRadius: 12.0, shadowRadius: 5.0)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? CPIViewModel else { return }
        
        let input = CPIViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    private var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    // Chỉ số giá tiêu dùng chung
    private var values0 = [104.42, 103.87, 105.04, 104.38, 103.39, 102.92]
    // Hàng ăn và dịch vụ ăn uống
    private var values1 = [104.05, 101.11, 100.14, 99.52, 97.92, 97.39]
    // Lương thực
    private var values2 = [104.36, 103.24, 102.49, 101.48, 101.24, 101.89]
    // Thực phẩm
    private var values3 = [103.83, 100.26, 99.6, 98.79, 96.28, 95.31]
    // Ăn uống ngoài gia đình
    private var values4 = [104.42, 102.1, 100.31, 100.3, 100.31, 100.3]
    // Đồ uống và thuốc lá
    private var values5 = [102.42, 101.09, 100.69, 100.72, 100.67, 100.64]
    // May mặc, mũ nón, giáy dép
    private var values6 = [104.61, 103.67, 103.06, 103.14, 102.93, 103.21]
    // Nhà ở, điện, nước, chất đốt, VLXD
    private var values7 = [102.71, 103.89, 104.35, 103.59, 102.51, 102.65]
    // Thiết bị và đồ dùng gia đình
    private var values8 = [101.57, 101.33, 101.36, 101.45, 101.38, 101.32]
    // Thuốc và dịch vụ y tế
    private var values9 = [123.1, 123.01, 148.15, 148.21, 148.2, 148.18]
    // Giao thông
    private var values10 = [105.72, 110.84, 116.11, 112.24, 109.52, 105.56]
    // Bưu chính viễn thông
    private var values11 = [99.31, 99.47, 99.59, 99.64, 99.71, 99.87]
    // Giáo dục
    private var values12 = [107.9, 107.9, 107.89, 107.89, 107.88, 107.9]
    // Văn hóa, giải trí và du lịch
    private var values13 = [99.84, 99.53, 100.29, 100.15, 100.35, 101.22]
    // Hàng hóa và dịch vụ khác
    private var values14 = [101.84, 101.09, 101.51, 101.38, 100.82, 100.86]
    
    private var controlList = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]
    
    func updateSwitch(index: Int, value: Bool){
        controlList[index] = value
        setChart()
    }
    
    func setChart() {
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
                        let dataEntry0 = ChartDataEntry(x: Double(i), y: values0[i], data: months[i] as AnyObject)
                        dataEntries0.append(dataEntry0)
                        
                        let chartDataSet0 = LineChartDataSet(entries: dataEntries0, label: nil)
                        chartDataSet0.circleRadius = 5
                        chartDataSet0.circleHoleRadius = 2
                        chartDataSet0.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet0.colors = [UIColor.App.ramsey]
                            chartDataSet0.circleColors = [UIColor.App.ramsey]
                        dataSets.append(chartDataSet0)
                    }

                case 1:
                    if(controlList[j]){
                        // Hàng ăn và dịch vụ ăn uống
                        let dataEntry1 = ChartDataEntry(x: Double(i), y: values1[i], data: months[i] as AnyObject)
                        dataEntries1.append(dataEntry1)
                        
                        let chartDataSet1 = LineChartDataSet(entries: dataEntries1, label: nil)
                        chartDataSet1.circleRadius = 5
                        chartDataSet1.circleHoleRadius = 2
                        chartDataSet1.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet1.colors = [UIColor.App.auba]
                            chartDataSet1.circleColors = [UIColor.App.auba]
                        dataSets.append(chartDataSet1)
                    }

                case 2:
                    if(controlList[j]){
                        // Lương thực
                        let dataEntry2 = ChartDataEntry(x: Double(i), y: values2[i], data: months[i] as AnyObject)
                        dataEntries2.append(dataEntry2)
                        
                        let chartDataSet2 = LineChartDataSet(entries: dataEntries2, label: nil)
                        chartDataSet2.circleRadius = 5
                        chartDataSet2.circleHoleRadius = 2
                        chartDataSet2.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet2.colors = [UIColor.App.laca]
                            chartDataSet2.circleColors = [UIColor.App.laca]
                        dataSets.append(chartDataSet2)
                    }
                case 3:
                    if(controlList[j]){
                        // Thực phẩm
                        let dataEntry3 = ChartDataEntry(x: Double(i), y: values3[i], data: months[i] as AnyObject)
                        dataEntries3.append(dataEntry3)
                        
                        let chartDataSet3 = LineChartDataSet(entries: dataEntries3, label: nil)
                        chartDataSet3.circleRadius = 5
                        chartDataSet3.circleHoleRadius = 2
                        chartDataSet3.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet3.colors = [UIColor.App.xhakar]
                            chartDataSet3.circleColors = [UIColor.App.xhakar]
                        dataSets.append(chartDataSet3)
                    }
                case 4:
                    if(controlList[j]){
                        // Ăn uống ngoài gia đình
                        let dataEntry4 = ChartDataEntry(x: Double(i), y: values4[i], data: months[i] as AnyObject)
                        dataEntries4.append(dataEntry4)
                        
                        let chartDataSet4 = LineChartDataSet(entries: dataEntries4, label: nil)
                        chartDataSet4.circleRadius = 5
                        chartDataSet4.circleHoleRadius = 2
                        chartDataSet4.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet4.colors = [UIColor.App.ozil]
                            chartDataSet4.circleColors = [UIColor.App.ozil]
                        dataSets.append(chartDataSet4)
                    }
                case 5:
                    if(controlList[j]){
                        // Đồ uống và thuốc lá
                        let dataEntry5 = ChartDataEntry(x: Double(i), y: values5[i], data: months[i] as AnyObject)
                        dataEntries5.append(dataEntry5)
                        
                        let chartDataSet5 = LineChartDataSet(entries: dataEntries5, label: nil)
                        chartDataSet5.circleRadius = 5
                        chartDataSet5.circleHoleRadius = 2
                        chartDataSet5.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet5.colors = [UIColor.App.toreira]
                            chartDataSet5.circleColors = [UIColor.App.toreira]
                        dataSets.append(chartDataSet5)
                    }
                case 6:
                    if(controlList[j]){
                        // Chỉ số giá tiêu dùng chung
                        let dataEntry6 = ChartDataEntry(x: Double(i), y: values6[i], data: months[i] as AnyObject)
                        dataEntries6.append(dataEntry6)
                        
                        let chartDataSet6 = LineChartDataSet(entries: dataEntries6, label: nil)
                        chartDataSet6.circleRadius = 5
                        chartDataSet6.circleHoleRadius = 2
                        chartDataSet6.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet6.colors = [UIColor.App.ramsey]
                            chartDataSet6.circleColors = [UIColor.App.ramsey]
                        dataSets.append(chartDataSet6)
                    }

                case 7:
                    if(controlList[j]){
                        // Hàng ăn và dịch vụ ăn uống
                        let dataEntry7 = ChartDataEntry(x: Double(i), y: values7[i], data: months[i] as AnyObject)
                        dataEntries7.append(dataEntry7)
                        
                        let chartDataSet7 = LineChartDataSet(entries: dataEntries7, label: nil)
                        chartDataSet7.circleRadius = 5
                        chartDataSet7.circleHoleRadius = 2
                        chartDataSet7.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet7.colors = [UIColor.App.auba]
                            chartDataSet7.circleColors = [UIColor.App.auba]
                        dataSets.append(chartDataSet7)
                    }

                case 8:
                    if(controlList[j]){
                        // Lương thực
                        let dataEntry8 = ChartDataEntry(x: Double(i), y: values8[i], data: months[i] as AnyObject)
                        dataEntries8.append(dataEntry8)
                        
                        let chartDataSet8 = LineChartDataSet(entries: dataEntries8, label: nil)
                        chartDataSet8.circleRadius = 5
                        chartDataSet8.circleHoleRadius = 2
                        chartDataSet8.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet8.colors = [UIColor.App.laca]
                            chartDataSet8.circleColors = [UIColor.App.laca]
                        dataSets.append(chartDataSet8)
                    }
                    
                case 9:
                    if(controlList[j]){
                        // Thực phẩm
                        let dataEntry9 = ChartDataEntry(x: Double(i), y: values9[i], data: months[i] as AnyObject)
                        dataEntries9.append(dataEntry9)
                        
                        let chartDataSet9 = LineChartDataSet(entries: dataEntries9, label: nil)
                        chartDataSet9.circleRadius = 5
                        chartDataSet9.circleHoleRadius = 2
                        chartDataSet9.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet9.colors = [UIColor.App.twitter]
                            chartDataSet9.circleColors = [UIColor.App.twitter]
                        dataSets.append(chartDataSet9)
                    }
                    
                case 10:
                    if(controlList[j]){
                        // Ăn uống ngoài gia đình
                        let dataEntry10 = ChartDataEntry(x: Double(i), y: values10[i], data: months[i] as AnyObject)
                        dataEntries10.append(dataEntry10)
                        
                        let chartDataSet10 = LineChartDataSet(entries: dataEntries10, label: nil)
                        chartDataSet10.circleRadius = 5
                        chartDataSet10.circleHoleRadius = 2
                        chartDataSet10.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet10.colors = [UIColor.App.ramsey]
                            chartDataSet10.circleColors = [UIColor.App.ramsey]
                        dataSets.append(chartDataSet10)
                    }
                    
                case 11:
                    if(controlList[j]){
                        // Hàng ăn và dịch vụ ăn uống
                        let dataEntry11 = ChartDataEntry(x: Double(i), y: values11[i], data: months[i] as AnyObject)
                        dataEntries11.append(dataEntry11)
                        
                        let chartDataSet11 = LineChartDataSet(entries: dataEntries11, label: nil)
                        chartDataSet11.circleRadius = 5
                        chartDataSet11.circleHoleRadius = 2
                        chartDataSet11.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet11.colors = [UIColor.App.ozil]
                            chartDataSet11.circleColors = [UIColor.App.ozil]
                        dataSets.append(chartDataSet11)
                    }

                case 12:
                    if(controlList[j]){
                        // Lương thực
                        let dataEntry12 = ChartDataEntry(x: Double(i), y: values12[i], data: months[i] as AnyObject)
                        dataEntries12.append(dataEntry12)
                        
                        let chartDataSet12 = LineChartDataSet(entries: dataEntries12, label: nil)
                        chartDataSet12.circleRadius = 5
                        chartDataSet12.circleHoleRadius = 2
                        chartDataSet12.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet12.colors = [UIColor.App.laca]
                            chartDataSet12.circleColors = [UIColor.App.laca]
                        dataSets.append(chartDataSet12)
                    }
                case 13:
                    if(controlList[j]){
                        // Thực phẩm
                        let dataEntry13 = ChartDataEntry(x: Double(i), y: values13[i], data: months[i] as AnyObject)
                        dataEntries13.append(dataEntry13)
                        
                        let chartDataSet13 = LineChartDataSet(entries: dataEntries13, label: nil)
                        chartDataSet13.circleRadius = 5
                        chartDataSet13.circleHoleRadius = 2
                        chartDataSet13.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet13.colors = [UIColor.App.auba]
                            chartDataSet13.circleColors = [UIColor.App.auba]
                        dataSets.append(chartDataSet13)
                    }
                case 14:
                    if(controlList[j]){
                        // Ăn uống ngoài gia đình
                        let dataEntry14 = ChartDataEntry(x: Double(i), y: values14[i], data: months[i] as AnyObject)
                        dataEntries14.append(dataEntry14)
                        
                        let chartDataSet14 = LineChartDataSet(entries: dataEntries14, label: nil)
                        chartDataSet14.circleRadius = 5
                        chartDataSet14.circleHoleRadius = 2
                        chartDataSet14.drawValuesEnabled = false
                        // set colors and enable value drawing
                        chartDataSet14.colors = [UIColor.App.toreira]
                            chartDataSet14.circleColors = [UIColor.App.toreira]
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
    }
    
    // quanth: round and shadow uiview
    private func addCtrlShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        control.layer.cornerRadius = cornerRadius
        control.layer.masksToBounds = true

        controlContent.layer.cornerRadius = cornerRadius
        controlContent.layer.masksToBounds = false

        controlContent.layer.shadowColor = UIColor.black.cgColor
        controlContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        controlContent.layer.shadowOpacity = 0.2
        controlContent.layer.shadowRadius = shadowRadius

        control.frame = control.bounds
        control.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
    
    // quanth: round and shadow uiview
    private func addChartShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        lineChartView.layer.cornerRadius = cornerRadius
        lineChartView.layer.masksToBounds = true

        lineChartContentView.layer.cornerRadius = cornerRadius
        lineChartContentView.layer.masksToBounds = false

        lineChartContentView.layer.shadowColor = UIColor.black.cgColor
        lineChartContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        lineChartContentView.layer.shadowOpacity = 0.2
        lineChartContentView.layer.shadowRadius = shadowRadius

        lineChartView.frame = lineChartView.bounds
        lineChartView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
    
    private func resizeSwitch(){
        aSwitch.set(width: 30, height: 20)
        bSwitch.set(width: 30, height: 20)
        cSwitch.set(width: 30, height: 20)
        eSwitch.set(width: 30, height: 20)
        fSwitch.set(width: 30, height: 20)
        
        gSwitch.set(width: 30, height: 20)
        hSwitch.set(width: 30, height: 20)
        iSwitch.set(width: 30, height: 20)
        kSwitch.set(width: 30, height: 20)
        lSwitch.set(width: 30, height: 20)
        
        mSwitch.set(width: 30, height: 20)
        nSwitch.set(width: 30, height: 20)
        oSwitch.set(width: 30, height: 20)
        pSwitch.set(width: 30, height: 20)
        qSwitch.set(width: 30, height: 20)
    }
    
    
    private func setupSwitch(){
        aSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(aSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 0, value: bool)
        }).disposed(by: disposeBag)
        
        bSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(bSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 1, value: bool)
        }).disposed(by: disposeBag)
        
        cSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(cSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 2, value: bool)
        }).disposed(by: disposeBag)
        
        eSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(eSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 3, value: bool)
        }).disposed(by: disposeBag)
        
        fSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(fSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 4, value: bool)
        }).disposed(by: disposeBag)
        
        gSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(gSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 5, value: bool)
        }).disposed(by: disposeBag)
        
        hSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(hSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 6, value: bool)
        }).disposed(by: disposeBag)
        
        iSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(iSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 7, value: bool)
        }).disposed(by: disposeBag)
        
        kSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(kSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 8, value: bool)
        }).disposed(by: disposeBag)
        
        lSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(lSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 9, value: bool)
        }).disposed(by: disposeBag)
        
        mSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(mSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 10, value: bool)
        }).disposed(by: disposeBag)
        
        nSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(nSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 11, value: bool)
        }).disposed(by: disposeBag)
        
        oSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(oSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 12, value: bool)
        }).disposed(by: disposeBag)
        
        pSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(pSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 13, value: bool)
        }).disposed(by: disposeBag)
        
        qSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(qSwitch.rx.value)
            .subscribe(onNext : { bool in
                self.updateSwitch(index: 14, value: bool)
        }).disposed(by: disposeBag)
    }
}
