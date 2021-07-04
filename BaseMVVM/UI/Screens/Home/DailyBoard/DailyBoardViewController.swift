//
//  DailyBoardViewController.swift
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

class DailyBoardViewController: ViewController {
    
    // MARK: View lifecycle
    
    @IBOutlet weak var contentView1: UIView!
    @IBOutlet weak var contentView3: UIView!
    @IBOutlet weak var contentView4: UIView!
    @IBOutlet weak var contentView2: UIView!
    @IBOutlet weak var contentArea1: UIView!
    @IBOutlet weak var contentArea2: UIView!
    @IBOutlet weak var contentArea3: UIView!
    @IBOutlet weak var contentArea4: UIView!
    
    private lazy var contentViewVC1: ViewController = {
        let viewController = ItemDailyBoardViewController(nibName: ItemDailyBoardViewController.className, bundle: nil)
        let navigator = ItemDailyBoardNavigator(with: viewController)
        let viewModel = ItemDailyBoardViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    private lazy var contentViewVC2: ViewController = {
        let viewController = ItemDailyBoardViewController(nibName: ItemDailyBoardViewController.className, bundle: nil)
        let navigator = ItemDailyBoardNavigator(with: viewController)
        let viewModel = ItemDailyBoardViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    private lazy var contentViewVC3: ViewController = {
        let viewController = ItemDailyBoardViewController(nibName: ItemDailyBoardViewController.className, bundle: nil)
        let navigator = ItemDailyBoardNavigator(with: viewController)
        let viewModel = ItemDailyBoardViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    private lazy var contentViewVC4: ViewController = {
        let viewController = ItemDailyBoardViewController(nibName: ItemDailyBoardViewController.className, bundle: nil)
        let navigator = ItemDailyBoardNavigator(with: viewController)
        let viewModel = ItemDailyBoardViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showContentView1()
        showContentView2()
        showContentView3()
        showContentView4()
    }
    
    override func makeUI() {
        super.makeUI()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? DailyBoardViewModel else { return }
        
        let input = DailyBoardViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    var currentContentView1: ViewController?
    var currentContentView2: ViewController?
    var currentContentView3: ViewController?
    var currentContentView4: ViewController?
    
    // Show list data
    private func showContentView1() {
        currentContentView1?.removeViewAndControllerFromParentViewController()
        addChildViewController(contentViewVC1, toContainerView: contentArea1)
        currentContentView1 = contentViewVC1
    }
    
    // Show list data
    private func showContentView2() {
        currentContentView2?.removeViewAndControllerFromParentViewController()
        addChildViewController(contentViewVC2, toContainerView: contentArea2)
        currentContentView2 = contentViewVC2
    }
    
    // Show list data
    private func showContentView3() {
        currentContentView3?.removeViewAndControllerFromParentViewController()
        addChildViewController(contentViewVC3, toContainerView: contentArea3)
        currentContentView3 = contentViewVC3
    }
    
    // Show list data
    private func showContentView4() {
        currentContentView4?.removeViewAndControllerFromParentViewController()
        addChildViewController(contentViewVC4, toContainerView: contentArea4)
        currentContentView4 = contentViewVC4
    }
}
