//
//  CPIViewController.swift
//  BaseMVVM
//
//  Created by Quan on 12/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa
import Charts
import FittedSheets

class CPIViewController: ViewController {
    

    @IBOutlet weak var forecastContent: UIView!
    @IBOutlet weak var forecastView: UIView!
    @IBOutlet weak var statisticalContent: UIView!
    @IBOutlet weak var statisticalView: UIView!
    @IBOutlet weak var ratioContent: UIView!
    @IBOutlet weak var ratioView: UIView!
    @IBOutlet weak var percentLeftView: UIView!
    @IBOutlet weak var percentRightView: UIView!
    
    private var cpiDatas: [CPIDataEntity] = []
    private var timelines: [String] = []
    
    private lazy var forecaseVC: ViewController = {
        let viewController = CPIForecastViewController(nibName: CPIForecastViewController.className, bundle: nil)
        let navigator = CPIForecastNavigator(with: viewController)
        let viewModel = CPIForecastViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.cpiDatas = cpiDatas
        viewController.timelines = timelines
        return viewController
    }()
    
    private lazy var statisticalVC: ViewController = {
        let viewController = CPIStatisticalViewController(nibName: CPIStatisticalViewController.className, bundle: nil)
        let navigator = CPIStatisticalNavigator(with: viewController)
        let viewModel = CPIStatisticalViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.cpiDatas = cpiDatas
        viewController.timelines = timelines
        return viewController
    }()
    
    private lazy var ratioVC: ViewController = {
        let viewController = CPIRatioViewController(nibName: CPIRatioViewController.className, bundle: nil)
        let navigator = CPIRatioNavigator(with: viewController)
        let viewModel = CPIRatioViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.cpiDatas = cpiDatas
        viewController.timelines = timelines
        return viewController
    }()
    
    private lazy var leftPercentVC: ViewController = {
        let viewController = CPIPercentViewController(nibName: CPIPercentViewController.className, bundle: nil)
        let navigator = CPIPercentNavigator(with: viewController)
        let viewModel = CPIPercentViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.chartTitle = "Thành phố"
//        viewController.cpiDatas = cpiDatas
//        viewController.timelines = timelines
        return viewController
    }()
    
    private lazy var rightPercentVC: ViewController = {
        let viewController = CPIPercentViewController(nibName: CPIPercentViewController.className, bundle: nil)
        let navigator = CPIPercentNavigator(with: viewController)
        let viewModel = CPIPercentViewModel(navigator: navigator)
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
        // quanth: showLoading
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator?.labelText = "Đang tải..."
        Indicator?.isUserInteractionEnabled = false
        Indicator?.show(true)
        
        addForecastShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addStatisticalShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addRatioShadow(cornerRadius: 12.0, shadowRadius: 5.0)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? CPIViewModel else { return }
        
        let input = CPIViewModel.Input()
        let output = viewModel.transform(input: input)
        
        // subcribe postal subject
        output.cpiDataSubject.subscribe(onNext: {[weak self] data in
            guard let self = self else { return }
            if(data != nil){
                self.cpiDatas = data?.cpi ?? []
                self.timelines = data?.timeline ?? []
                self.embedForecastView()
                self.embedStatisticalView()
                self.embedRatioView()
                self.embedLeftPercentView()
                self.embedRightPercentView()
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.fetchCPIIndexs()
    }
    
    // quanth: round and shadow uiview
    private func addForecastShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        forecastView.layer.cornerRadius = cornerRadius
        forecastView.layer.masksToBounds = true

        forecastContent.layer.cornerRadius = cornerRadius
        forecastContent.layer.masksToBounds = false

        forecastContent.layer.shadowColor = UIColor.black.cgColor
        forecastContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        forecastContent.layer.shadowOpacity = 0.2
        forecastContent.layer.shadowRadius = shadowRadius

        forecastView.frame = forecastView.bounds
        forecastView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
    }
    
    // quanth: round and shadow uiview
    private func addStatisticalShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        statisticalView.layer.cornerRadius = cornerRadius
        statisticalView.layer.masksToBounds = true

        statisticalContent.layer.cornerRadius = cornerRadius
        statisticalContent.layer.masksToBounds = false

        statisticalContent.layer.shadowColor = UIColor.black.cgColor
        statisticalContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        statisticalContent.layer.shadowOpacity = 0.2
        statisticalContent.layer.shadowRadius = shadowRadius

        statisticalView.frame = statisticalView.bounds
        statisticalView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
    }
    
    // quanth: round and shadow uiview
    private func addRatioShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        ratioView.layer.cornerRadius = cornerRadius
        ratioView.layer.masksToBounds = true

        ratioContent.layer.cornerRadius = cornerRadius
        ratioContent.layer.masksToBounds = false

        ratioContent.layer.shadowColor = UIColor.black.cgColor
        ratioContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        ratioContent.layer.shadowOpacity = 0.2
        ratioContent.layer.shadowRadius = shadowRadius

        ratioView.frame = ratioView.bounds
        ratioView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
    }
    
    // Show forecast view
    private func embedForecastView() {
        addChildViewController(forecaseVC, toContainerView: forecastView)
    }
    
    // Show statistical view
    private func embedStatisticalView() {
        addChildViewController(statisticalVC, toContainerView: statisticalView)
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        MBProgressHUD.hide(for: self.view, animated: true)
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
