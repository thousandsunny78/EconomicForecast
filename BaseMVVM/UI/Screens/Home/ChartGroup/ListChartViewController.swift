//
//  ListChartViewController.swift
//  BaseMVVM
//
//  Created by Quan on 05/07/2021.
//  Copyright (c) 2021 quanth.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa

class ListChartViewController: ViewController {
    
    @IBOutlet weak var listChart: UITableView!
    // MARK: View lifecycle
    
    private let refreshControl = UIRefreshControl()
    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()
    
    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // quanth: thay đổi background của refresh control
        refreshControl.backgroundColor = UIColor.App.tabUnselected
    }
    
    override func makeUI() {
        super.makeUI()
        listChart.register(nibWithCellClass: ItemChartTableViewCell.self)
        listChart.tableFooterView = UIView()
        listChart.refreshControl = refreshControl
        isHeaderLoading.subscribe(onNext: { [weak self] (isLoading) in
            guard let self = self else { return }
            if isLoading {
                self.refreshControl.beginRefreshing()
            } else {
                self.refreshControl.endRefreshing()
            }
        }).disposed(by: disposeBag)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? ListChartViewModel else { return }
        
        let itemSelected = listChart.rx.modelSelected(ItemChartCellViewModel.self).asDriver()
        let refresh = Observable.of(Observable.just(()), headerRefreshTrigger).merge()
        let input = ListChartViewModel.Input(headerRefresh: refresh,
                                         footerRefresh: footerRefreshTrigger,
                                         selection: itemSelected)
        let output = viewModel.transform(input: input)
        
        viewModel.loading.asObservable().bind(to: isLoading).disposed(by: disposeBag)
        viewModel.headerLoading.asObservable().bind(to: isHeaderLoading).disposed(by: disposeBag)
        viewModel.footerLoading.asObservable().bind(to: isFooterLoading).disposed(by: disposeBag)
        
        output.items.asDriver(onErrorJustReturn: [])
            .drive(self.listChart.rx.items(cellIdentifier: ItemChartTableViewCell.className, cellType: ItemChartTableViewCell.self)) { tableView, viewModel, cell in
                cell.bind(viewModel: viewModel)
        }.disposed(by: self.disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged).bind { [weak self] _ in
            guard let self = self else { return }
            self.headerRefreshTrigger.onNext(())
        }.disposed(by: disposeBag)
        
        listChart.rx.prefetchRows.subscribe(onNext: {[weak self] indexPaths in
            guard let self = self else { return }
            let count = output.items.value.count
            if indexPaths.contains(where: { (indexPath) -> Bool in
                return count == indexPath.row + 1
            }) {
                self.footerRefreshTrigger.onNext(())
            }
        }).disposed(by: disposeBag)
    
    }
}
