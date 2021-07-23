//
//  CPICollectionBSViewModel.swift
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

class CPICollectionBSViewModel: ViewModel, ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        let items: BehaviorRelay<[CPICellViewModel]>
    }
    
    private let navigator: CPICollectionBSNavigator
    private let titles = BehaviorRelay<[String]>(value: [])

    init(navigator: CPICollectionBSNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
        titles.accept(["cpi","iip","gdp","xnk","that_nghiep","thu_chi","dang_xuat"])
    }

    func transform(input: Input) -> Output {
        //Output
        let elements = BehaviorRelay<[CPICellViewModel]>(value: [])
        titles.map { text -> [CPICellViewModel] in
            return text.map { text -> CPICellViewModel in
                var item: CPIItem? = nil
                item = CPIItem(name: text)
                return CPICellViewModel(item: item!)
            }
        }.bind(to: elements).disposed(by: disposeBag)
        return Output(items: elements)
    }
}
