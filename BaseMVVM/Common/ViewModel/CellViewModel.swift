//
//  CellViewModel.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 1/4/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CellViewModel {
    var disposeBag = DisposeBag()
    
    let title = BehaviorRelay<String?>(value: nil)
    let detail = BehaviorRelay<String?>(value: nil)
    let imageUrl = BehaviorRelay<String?>(value: nil)
}
