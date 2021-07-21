//
//  MenuListViewModel.swift
//  BaseMVVM
//
//  Created by Quan on 20/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import Foundation
import RxSwift
import RxCocoa

class MenuListViewModel: ViewModel, ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        let items: BehaviorRelay<[MenuListCellViewModel]>
    }
    
    private let navigator: MenuListNavigator
    private let titles = BehaviorRelay<[String]>(value: [])

    init(navigator: MenuListNavigator) {
        self.navigator = navigator
        super.init(navigator: navigator)
        titles.accept(["cpi","iip","gdp","xnk","that_nghiep","thu_chi","dang_xuat"])
    }

    func transform(input: Input) -> Output {
        //Output
        let elements = BehaviorRelay<[MenuListCellViewModel]>(value: [])
        titles.map { text -> [MenuListCellViewModel] in
            return text.map { text -> MenuListCellViewModel in
                var menuItem: MenuItem? = nil
                if(text == "cpi"){
                    menuItem = MenuItem(image: UIImage(named:"ic_cpi_menu")!, name: "Chỉ số CPI")
                } else if(text == "iip"){
                    menuItem = MenuItem(image: UIImage(named:"ic_iip_menu")!, name: "Chỉ số IIP")
                } else if(text == "gdp"){
                    menuItem = MenuItem(image: UIImage(named:"ic_gdp_menu")!, name: "Chỉ số GDP")
                } else if(text == "xnk"){
                    menuItem = MenuItem(image: UIImage(named:"ic_xnk_menu")!, name: "Xuất nhập khẩu")
                } else if(text == "that_nghiep"){
                    menuItem = MenuItem(image: UIImage(named:"ic_thatnghiep_menu")!, name: "Tỷ lệ thất nghiệp")
                } else if(text == "thu_chi"){
                    menuItem = MenuItem(image: UIImage(named:"ic_thuchi_menu")!, name: "Thu chi ngân sách")
                } else {
                    menuItem = MenuItem(image: UIImage(named:"ic_logout_menu")!, name: "Đăng xuất")
                }
                return MenuListCellViewModel(item: menuItem!)
            }
        }.bind(to: elements).disposed(by: disposeBag)
        return Output(items: elements)
    }
}
