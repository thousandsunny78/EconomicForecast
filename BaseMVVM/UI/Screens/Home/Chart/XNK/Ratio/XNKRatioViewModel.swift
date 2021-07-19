//
//  XNKRatioViewModel.swift
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

class XNKRatioViewModel: ViewModel, ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private let navigator: XNKRatioNavigator

    init(navigator: XNKRatioNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }

    func transform(input: Input) -> Output {
        
        return Output()
    }
}
