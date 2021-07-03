//
//  ItemCellViewModel.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 4/29/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import Foundation

class ItemCellViewModel: CellViewModel {
    let item: Item
    
    init(item: Item) {
        self.item = item
        super.init()
        self.title.accept(item.name)
        self.imageUrl.accept(item.thumbnail)
    }
}
