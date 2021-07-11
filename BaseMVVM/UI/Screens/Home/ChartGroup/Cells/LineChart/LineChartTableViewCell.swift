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
}
