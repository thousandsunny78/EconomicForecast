//
//  MainViewModel.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 1/4/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import Foundation
import RxCocoa

class SplashViewModel: ViewModel, ViewModelType{
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private let navigator: SplashNavigator
    
    init(navigator: SplashNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
        
        if AuthManager.shared.loggedIn.value {
            navigator.pushHome()
        } else {
            navigator.pushSignIn()
        }
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
