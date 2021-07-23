//
//  CPICellViewModel.swift
//  BaseMVVM
//
//  Created by Quan on 22/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import Foundation
import RxSwift
import RxCocoa

class CPICellViewModel: CellViewModel {
    let item: CPIItem
    
    init(item: CPIItem) {
        self.item = item
        super.init()
        self.title.accept(item.name)
    }
}
