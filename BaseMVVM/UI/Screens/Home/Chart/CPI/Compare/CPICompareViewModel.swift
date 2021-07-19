//
//  CPICompareViewModel.swift
//  BaseMVVM
//
//  Created by Quan on 19/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import Foundation
import RxSwift
import RxCocoa

class CPICompareViewModel: ViewModel, ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private let navigator: CPICompareNavigator

    init(navigator: CPICompareNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }

    func transform(input: Input) -> Output {
        
        return Output()
    }
}
