//
//  EconamicFocastViewController.swift
//  BaseMVVM
//
//  Created by Quan on 03/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa

class EconamicFocastViewController: ViewController {
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? EconamicFocastViewModel else { return }
        
        let input = EconamicFocastViewModel.Input()
        let output = viewModel.transform(input: input)
    }
}
