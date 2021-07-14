//
//  CPIViewModel.swift
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

class CPIViewModel: ViewModel, ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        let cpiDataSubject: BehaviorRelay<[DataEntity]>
    }
    
    /// to store data retrieve from server
    private let cpiDatas = BehaviorRelay<[DataEntity]>(value: [])
    
    private let navigator: CPINavigator

    init(navigator: CPINavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }

    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[DataEntity]>(value: [])
        return Output(cpiDataSubject: cpiDatas)
    }
    
    func fetchCPIIndexs() {
        Application.shared.apiProvider.getCPIIndexs().trackActivity(loading).subscribe(
            onNext: { [weak self] respones in
            guard let self = self else { return }
            if respones.data.isEmpty {
                return
            }
            self.cpiDatas.accept(respones.data)
            }, onError: {[weak self] error in
                self?.navigator.showAlert(title: "Common.Error".localized(),
                                          message: "fetchCPIIndexs".localized())
        }).disposed(by: disposeBag)
    }
}
