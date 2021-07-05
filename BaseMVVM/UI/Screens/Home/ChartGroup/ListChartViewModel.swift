//
//  ListChartViewModel.swift
//  BaseMVVM
//
//  Created by Quan on 05/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import Foundation
import RxSwift
import RxCocoa

class ListChartViewModel: ViewModel, ViewModelType {
    struct Input {
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
        let selection: Driver<ItemChartCellViewModel>
    }
    
    struct Output {
        let items: BehaviorRelay<[ItemChartCellViewModel]>
    }
    
    private let navigator: ListChartNavigator
    
    private var page = 1
    
    private let charts = BehaviorRelay<[Chart]>(value: [])

    init(navigator: ListChartNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
    }

    func transform(input: Input) -> Output {
        //Input
        input.headerRefresh.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.page = 1
            self.fetchItems(at: self.page)
        }).disposed(by: disposeBag)
        
        input.footerRefresh.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.fetchItems(at: self.page + 1)
        }).disposed(by: disposeBag)
        //Output
        let elements = BehaviorRelay<[ItemChartCellViewModel]>(value: [])
        charts.map { charts -> [ItemChartCellViewModel] in
            return charts.map { chart -> ItemChartCellViewModel in
                return ItemChartCellViewModel(item: chart)
            }
        }.bind(to: elements).disposed(by: disposeBag)
        return Output(items: elements)
    }
    
    private func fetchItems(at page: Int) {
        
        self.page = page
        if page == 1 {
            let chart1 = Chart(id: "1", name: "hello")
            let chart2 = Chart(id: "2", name: "hello 1")
            let chart3 = Chart(id: "3", name: "hello 3")
            self.charts.accept([chart1, chart2, chart3])
        } else {
            let chart1 = Chart(id: "1", name: "hello")
            let chart2 = Chart(id: "2", name: "hello 1")
            let chart3 = Chart(id: "3", name: "hello 3")
            self.charts.accept(self.charts.value + [chart1, chart2, chart3])
        }
        
//        Application.shared.apiProvider.getItems(page: page, pageSize: 20)
//            .trackActivity(page == 1 ? headerLoading : footerLoading)
//            .subscribe(
//                onNext: { [weak self] response in
//                    guard let self = self else { return }
//                    if response.results.isEmpty && page != 1 {
//                        return
//                    }
//                    self.page = page
//                    if page == 1 {
//                        self.movies.accept(response.results)
//                    } else {
//                        self.movies.accept(self.movies.value + response.results)
//                    }
//                }, onError: { [weak self] error in
//                    self?.navigator.showAlert(title: "Error",
//                                              message: error.localizedDescription)
//            }).disposed(by: disposeBag)
    }
}
