//
//  BarChartCellViewModel.swift
//  BaseMVVM
//
//  Created by Quan on 12/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import Foundation
import RxSwift
import RxCocoa

class BarChartCellViewModel: CellViewModel {
    let item: Chart
    
    init(item: Chart) {
        self.item = item
        super.init()
        self.title.accept(item.name)
    }
}
