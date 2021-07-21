//
//  HomeChartViewModel.swift
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

class HomeChartViewModel: ViewModel, ViewModelType {
    struct Input {
        let menuAction: Driver<Void>
    }
    
    struct Output {
        
    }
    
    private let navigator: HomeChartNavigator

    init(navigator: HomeChartNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }

    func transform(input: Input) -> Output {
        input.menuAction.drive(onNext: { [weak self] _ in
            self?.navigator.presentSideMenu()
        }).disposed(by: disposeBag)
        return Output()
    }
    
    func logout() {
        AuthManager.shared.token = nil
        UserManager.shared.removeUser()
        Application.shared.presentInitialScreen(in: appDelegate.window)
    }
}
