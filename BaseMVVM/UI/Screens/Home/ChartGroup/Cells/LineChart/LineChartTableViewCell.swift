//
//  LineChartTableViewCell.swift
//  BaseMVVM
//
//  Created by Quan on 10/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa
import Charts

class LineChartTableViewCell: TableViewCell {
    
    @IBOutlet weak var lineChartContentView: UIView!
    @IBOutlet weak var lineChartView: LineChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func bind(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? LineChartCellViewModel else {
            return
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        setChart()
        //customizeChart(dataPoints: players, values: goals.map{ Double($0) })
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {

      var dataEntries: [ChartDataEntry] = []

      for i in 0..<dataPoints.count {
        let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
        dataEntries.append(dataEntry)
      }

        // 2. Set ChartDataSet
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        // 3. Set ChartData
      let lineChartData = LineChartData(dataSet: lineChartDataSet)
        // 4. Assign it to the chart's data
      lineChartView.data = lineChartData
    }
    
    // quanth: round and shadow uiview
    private func addShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        lineChartView.layer.cornerRadius = cornerRadius
        lineChartView.layer.masksToBounds = true

        lineChartContentView.layer.cornerRadius = cornerRadius
        lineChartContentView.layer.masksToBounds = false

        lineChartContentView.layer.shadowColor = UIColor.black.cgColor
        lineChartContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        lineChartContentView.layer.shadowOpacity = 0.2
        lineChartContentView.layer.shadowRadius = shadowRadius

        lineChartView.frame = lineChartContentView.bounds
        lineChartView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
    }
    
    private var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    private var values1 = [104.42, 103.87, 105.04, 104.38, 103.39, 102.92]
    private var values2 = [104.05, 101.11, 100.14, 99.52, 97.92, 97.39]
    
    func setChart() {
        var dataEntries1: [ChartDataEntry] = []
        var dataEntries2: [ChartDataEntry] = []

        for i in 0..<months.count {
            let dataEntry1 = ChartDataEntry(x: Double(i), y: values1[i], data: months[i] as AnyObject)
            let dataEntry2 = ChartDataEntry(x: Double(i), y: values2[i], data: months[i] as AnyObject)
            dataEntries1.append(dataEntry1)
            dataEntries2.append(dataEntry2)
        }

        // Chỉ số giá tiêu dùng chung
        let chartDataSet1 = LineChartDataSet(entries: dataEntries1, label: nil)
        chartDataSet1.circleRadius = 5
        chartDataSet1.circleHoleRadius = 2
        chartDataSet1.drawValuesEnabled = false
        // set colors and enable value drawing
        chartDataSet1.colors = [UIColor.App.ramsey]
        chartDataSet1.circleColors = [UIColor.App.ramsey]
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChartView.xAxis.setLabelCount(months.count, force: true)
        
        // Hàng ăn và dịch vụ ăn uống
        let chartDataSet2 = LineChartDataSet(entries: dataEntries2, label: nil)
        chartDataSet2.circleRadius = 5
        chartDataSet2.circleHoleRadius = 2
        chartDataSet2.drawValuesEnabled = false
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChartView.xAxis.setLabelCount(months.count, force: true)

        let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2])
        lineChartView.data = chartData

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
}
