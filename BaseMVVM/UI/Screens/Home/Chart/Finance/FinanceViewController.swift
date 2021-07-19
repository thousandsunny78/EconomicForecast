//
//  FinanceViewController.swift
//  BaseMVVM
//
//  Created by Quan on 19/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa

class FinanceViewController: ViewController {
    
    @IBOutlet weak var revenueContent: UIView!
    @IBOutlet weak var revenueView: UIView!
    @IBOutlet weak var expenseContent: UIView!
    @IBOutlet weak var expenseView: UIView!
    
    private var expenseDatas: [CPIDataEntity] = []
    private var timelines: [String] = []
    
    private lazy var expenseVC: ViewController = {
        let viewController = ExpenseViewController(nibName: ExpenseViewController.className, bundle: nil)
        let navigator = ExpenseNavigator(with: viewController)
        let viewModel = ExpenseViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.chartTitle = "25.994 tỷ vnđ"
        return viewController
    }()
    
    private lazy var revenueVC: ViewController = {
        let viewController = RevenueViewController(nibName: RevenueViewController.className, bundle: nil)
        let navigator = RevenueNavigator(with: viewController)
        let viewModel = RevenueViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.chartTitle = "15.350 tỷ vnđ"
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addExpenseShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addRevenueShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        self.embedExpenseView()
        self.embedRevenueView()
    }
    
    override func makeUI() {
        super.makeUI()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? FinanceViewModel else { return }
        
        let input = FinanceViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    // quanth: round and shadow uiview
    private func addExpenseShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        expenseView.layer.cornerRadius = cornerRadius
        expenseView.layer.masksToBounds = true

        expenseContent.layer.cornerRadius = cornerRadius
        expenseContent.layer.masksToBounds = false

        expenseContent.layer.shadowColor = UIColor.black.cgColor
        expenseContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        expenseContent.layer.shadowOpacity = 0.2
        expenseContent.layer.shadowRadius = shadowRadius

        expenseView.frame = expenseView.bounds
        expenseView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
    }
    
    // quanth: round and shadow uiview
    private func addRevenueShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        revenueView.layer.cornerRadius = cornerRadius
        revenueView.layer.masksToBounds = true

        revenueContent.layer.cornerRadius = cornerRadius
        revenueContent.layer.masksToBounds = false

        revenueContent.layer.shadowColor = UIColor.black.cgColor
        revenueContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        revenueContent.layer.shadowOpacity = 0.2
        revenueContent.layer.shadowRadius = shadowRadius

        revenueView.frame = revenueView.bounds
        revenueView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
    }
    
    // Show ratio view
    private func embedExpenseView() {
        addChildViewController(expenseVC, toContainerView: expenseView)
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        //MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    // Show ratio view
    private func embedRevenueView() {
        addChildViewController(revenueVC, toContainerView: revenueView)
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        //MBProgressHUD.hide(for: self.view, animated: true)
    }
    
}
