//
//  ItemChartTableViewCell.swift
//  BaseMVVM
//
//  Created by Quan on 05/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa
import Charts

class ItemChartTableViewCell: TableViewCell {
    
    @IBOutlet weak var pieChartView: PieChartView!

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
        guard let viewModel = viewModel as? ItemChartCellViewModel else {
            return
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
      
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry)
      }
      
      // 2. Set ChartDataSet
      let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
      
      // 3. Set ChartData
      let pieChartData = PieChartData(dataSet: pieChartDataSet)
      let format = NumberFormatter()
      format.numberStyle = .none
      let formatter = DefaultValueFormatter(formatter: format)
      pieChartData.setValueFormatter(formatter)
      
      // 4. Assign it to the chart's data
      pieChartView.data = pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for i in 0..<numbersOfColor {
        switch i {
        case 0:
            let color = UIColor.App.xhakar
            colors.append(color)

        case 1:
            let color = UIColor.App.toreira
            colors.append(color)
            
        case 2:
            let color = UIColor.App.ozil
            colors.append(color)

        case 3:
            let color = UIColor.App.ramsey
            colors.append(color)
            
        case 4:
            let color = UIColor.App.laca
            colors.append(color)
            
        case 5:
            let color = UIColor.App.auba
            colors.append(color)

        default:
            print("Have you done something new?")
        }
      }
      return colors
    }
}
