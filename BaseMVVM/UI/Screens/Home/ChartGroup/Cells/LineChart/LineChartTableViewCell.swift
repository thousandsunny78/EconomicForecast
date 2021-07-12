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
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
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
}
