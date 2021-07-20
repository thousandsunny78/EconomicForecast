//
//  MenuListCellViewModel.swift
//  BaseMVVM
//
//  Created by Quan on 20/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import Foundation
import RxSwift
import RxCocoa

class MenuListCellViewModel: CellViewModel {
    let item: MenuItem
    
    init(item: MenuItem) {
        self.item = item
        super.init()
        self.title.accept(item.name)
        self.image.accept(item.image)
    }
    
}
