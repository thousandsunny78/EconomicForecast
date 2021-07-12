//
//  BarChartTableViewCell.swift
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

class BarChartTableViewCell: TableViewCell {
    

    @IBOutlet weak var barChartContentView: UIView!
    @IBOutlet weak var barChartView: LineChartView!
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
        guard let viewModel = viewModel as? BarChartCellViewModel else {
            return
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        barChartView.animate(yAxisDuration: 2.0)
            barChartView.pinchZoomEnabled = false
            //barChartView.drawBarShadowEnabled = false
            barChartView.drawBordersEnabled = false
            barChartView.doubleTapToZoomEnabled = false
            barChartView.drawGridBackgroundEnabled = true
            barChartView.chartDescription?.text = "Bar Chart View"
            
            setChart(dataPoints: players, values: goals.map { Double($0) })
    }
    
    private func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
          let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
          dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
      }
    
    // quanth: round and shadow uiview
    private func addShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        barChartView.layer.cornerRadius = cornerRadius
        barChartView.layer.masksToBounds = true

        barChartContentView.layer.cornerRadius = cornerRadius
        barChartContentView.layer.masksToBounds = false

        barChartContentView.layer.shadowColor = UIColor.black.cgColor
        barChartContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        barChartContentView.layer.shadowOpacity = 0.2
        barChartContentView.layer.shadowRadius = shadowRadius

        barChartView.frame = barChartContentView.bounds
        barChartView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
    }
}
