//
//  ItemDailyBoardViewController.swift
//  BaseMVVM
//
//  Created by Quan on 04/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa

class ItemDailyBoardViewController: ViewController {
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? ItemDailyBoardViewModel else { return }
        
        let input = ItemDailyBoardViewModel.Input()
        let output = viewModel.transform(input: input)
    }
}
