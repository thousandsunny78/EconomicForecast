//
//  IIPViewModel.swift
//  BaseMVVM
//
//  Created by Quan on 13/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import Foundation
import RxSwift
import RxCocoa

class IIPViewModel: ViewModel, ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        let iipDataSubject: BehaviorRelay<DataEntity?>
    }
    
    /// to store data retrieve from server
    private let iipDatas = BehaviorRelay<DataEntity?>(value: nil)
    
    private let navigator: IIPNavigator

    init(navigator: IIPNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }

    func transform(input: Input) -> Output {
        //Output
        let elements = BehaviorRelay<DataEntity?>(value: nil)
        return Output(iipDataSubject: iipDatas)
    }
    
    func fetchIIPIndexs() {
        Application.shared.apiProvider.getCPIIndexs().trackActivity(loading).subscribe(
            onNext: { [weak self] respones in
            guard let self = self else { return }
            if respones == nil {
                return
            }
            self.iipDatas.accept(respones.data)
            }, onError: {[weak self] error in
                self?.navigator.showAlert(title: "Common.Error".localized(),
                                          message: "fetchCPIIndexs".localized())
        }).disposed(by: disposeBag)
    }
}
