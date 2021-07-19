//
//  GDPViewModel.swift
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

class GDPViewModel: ViewModel, ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        let gdpDataSubject: BehaviorRelay<DataEntity?>
    }
    
    /// to store data retrieve from server
    private let gdpDatas = BehaviorRelay<DataEntity?>(value: nil)
    
    private let navigator: GDPNavigator

    init(navigator: GDPNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }

    func transform(input: Input) -> Output {
        //Output
        let elements = BehaviorRelay<DataEntity?>(value: nil)
        return Output(gdpDataSubject: gdpDatas)
    }
    
    func fetchGDPIndexs() {
        Application.shared.apiProvider.getCPIIndexs().trackActivity(loading).subscribe(
            onNext: { [weak self] respones in
            guard let self = self else { return }
            if respones == nil {
                return
            }
            self.gdpDatas.accept(respones.data)
            }, onError: {[weak self] error in
                self?.navigator.showAlert(title: "Common.Error".localized(),
                                          message: "fetchCPIIndexs".localized())
        }).disposed(by: disposeBag)
    }
}
