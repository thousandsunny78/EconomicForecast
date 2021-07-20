//
//  CombinedViewModel.swift
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

class CombinedViewModel: ViewModel, ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private let navigator: CombinedNavigator

    init(navigator: CombinedNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }

    func transform(input: Input) -> Output {
        
        return Output()
    }
}
