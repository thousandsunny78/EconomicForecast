//
//  MenuListViewController.swift
//  BaseMVVM
//
//  Created by Quan on 20/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa

class MenuListViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var banner: UIView!
    var home: HomeChartViewController? = nil
    var items = ["First", "Second", "Third", "First", "Second", "Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        self.banner.backgroundColor = UIColor(patternImage: UIImage(named: "ic_background_app")!)
        tableView.register(nibWithCellClass: MenuListTableViewCell.self)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? MenuListViewModel else { return }
        
        let input = MenuListViewModel.Input()
        let output = viewModel.transform(input: input)
        output.items.asDriver(onErrorJustReturn: [])
            .drive(self.tableView.rx.items(cellIdentifier: MenuListTableViewCell.className, cellType: MenuListTableViewCell.self)) { tableView, viewModel, cell in
                cell.bind(viewModel: viewModel)
                /// quanth: bỏ line giữa các item
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        }.disposed(by: self.disposeBag)
        
        tableView.rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
            
            switch indexPath.row {
            case 0:
                self?.home?.showTab1()
                self?.home?.hideSideMenu()
            case 1:
                self?.home?.showTab2()
                self?.home?.hideSideMenu()
            case 2:
                self?.home?.showTab3()
                self?.home?.hideSideMenu()
            case 3:
                self?.home?.showTab4()
                self?.home?.hideSideMenu()
            case 4:
                self?.home?.showTab5()
                self?.home?.hideSideMenu()
            case 5:
                self?.home?.showTab6()
                self?.home?.hideSideMenu()
            case 5:
                self?.home?.showTab6()
                self?.home?.hideSideMenu()
            case 6:
                self?.home?.logout()
            default:
                print("quanth do nothing")
            }
          }).addDisposableTo(disposeBag)
    }
}
