//
//  GDPViewController.swift
//  BaseMVVM
//
//  Created by Quan on 18/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa

class UnemploymentViewController: ViewController {
    
    
    @IBOutlet weak var ratioContent: UIView!
    @IBOutlet weak var ratioArea: UIView!
    @IBOutlet weak var ratioView: UIView!
    @IBOutlet weak var percentLeftView: UIView!
    @IBOutlet weak var percentRightView: UIView!
    
    private var cpiDatas: [CPIDataEntity] = []
    private var timelines: [String] = []
    
    private lazy var ratioVC: ViewController = {
        let viewController = UETRatioViewController(nibName: UETRatioViewController.className, bundle: nil)
        let navigator = UETRatioNavigator(with: viewController)
        let viewModel = UETRatioViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.cpiDatas = cpiDatas
        viewController.timelines = timelines
        return viewController
    }()
    
    private lazy var leftPercentVC: ViewController = {
        let viewController = UETPercentViewController(nibName: UETPercentViewController.className, bundle: nil)
        let navigator = UETPercentNavigator(with: viewController)
        let viewModel = UETPercentViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.chartTitle = "Thành phố"
//        viewController.cpiDatas = cpiDatas
//        viewController.timelines = timelines
        return viewController
    }()
    
    private lazy var rightPercentVC: ViewController = {
        let viewController = UETPercent2ViewController(nibName: UETPercent2ViewController.className, bundle: nil)
        let navigator = UETPercent2Navigator(with: viewController)
        let viewModel = UETPercent2ViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.chartTitle = "Ngoại ô"
//        viewController.cpiDatas = cpiDatas
//        viewController.timelines = timelines
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        
        addRatioShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        self.embedRatioView()
        self.embedLeftPercentView()
        self.embedRightPercentView()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? UnemploymentViewModel else { return }
        
        let input = UnemploymentViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    // quanth: round and shadow uiview
    private func addRatioShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        ratioArea.layer.cornerRadius = cornerRadius
        ratioArea.layer.masksToBounds = true

        ratioContent.layer.cornerRadius = cornerRadius
        ratioContent.layer.masksToBounds = false

        ratioContent.layer.shadowColor = UIColor.black.cgColor
        ratioContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        ratioContent.layer.shadowOpacity = 0.2
        ratioContent.layer.shadowRadius = shadowRadius

        ratioArea.frame = ratioArea.bounds
        ratioArea.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
    }
    
    // Show ratio view
    private func embedRatioView() {
        addChildViewController(ratioVC, toContainerView: ratioView)
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        //MBProgressHUD.hide(for: self.view, animated: true)
    }

    // Show ratio view
    private func embedLeftPercentView() {
        addChildViewController(leftPercentVC, toContainerView: percentLeftView)
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        //MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    // Show ratio view
    private func embedRightPercentView() {
        addChildViewController(rightPercentVC, toContainerView: percentRightView)
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        //MBProgressHUD.hide(for: self.view, animated: true)
    }
}
