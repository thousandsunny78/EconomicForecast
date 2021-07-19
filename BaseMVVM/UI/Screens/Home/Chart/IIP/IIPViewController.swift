//
//  IIPViewController.swift
//  BaseMVVM
//
//  Created by Quan on 13/07/2021.
//  Copyright (c) 2021 quanth.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa
import Charts

class IIPViewController: ViewController {
    
    
    @IBOutlet weak var forecastContent: UIView!
    @IBOutlet weak var forecastView: UIView!
    @IBOutlet weak var statisticalContent: UIView!
    @IBOutlet weak var statisticalView: UIView!
    @IBOutlet weak var compareContent: UIView!
    @IBOutlet weak var compareView: UIView!
    
    private var iipDatas: [CPIDataEntity] = []
    private var timelines: [String] = []
    
    private lazy var forecaseVC: ViewController = {
        let viewController = IIPForecastViewController(nibName: IIPForecastViewController.className, bundle: nil)
        let navigator = IIPForecastNavigator(with: viewController)
        let viewModel = IIPForecastViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.iipDatas = iipDatas
        viewController.timelines = timelines
        return viewController
    }()
    
    private lazy var statisticalVC: ViewController = {
        let viewController = IIPStatisticalViewController(nibName: IIPStatisticalViewController.className, bundle: nil)
        let navigator = IIPStatisticalNavigator(with: viewController)
        let viewModel = IIPStatisticalViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.iipDatas = iipDatas
        viewController.timelines = timelines
        return viewController
    }()
    
    private lazy var compareVC: ViewController = {
        let viewController = IIPCompareViewController(nibName: IIPCompareViewController.className, bundle: nil)
        let navigator = IIPCompareNavigator(with: viewController)
        let viewModel = IIPCompareViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.iipDatas = iipDatas
        viewController.timelines = timelines
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
        addCompareViewShadow(cornerRadius: 12.0, shadowRadius: 5.0)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? IIPViewModel else { return }
        
        let input = IIPViewModel.Input()
        let output = viewModel.transform(input: input)
        
        // subcribe postal subject
        output.iipDataSubject.subscribe(onNext: {[weak self] data in
            guard let self = self else { return }
            if(data != nil){
                self.iipDatas = data?.cpi ?? []
                self.timelines = data?.timeline ?? []
                self.embedForecastView()
                self.embedStatisticalView()
                self.embedCompareView()
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.fetchIIPIndexs()
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
    private func addCompareViewShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        compareView.layer.cornerRadius = cornerRadius
        compareView.layer.masksToBounds = true

        compareContent.layer.cornerRadius = cornerRadius
        compareContent.layer.masksToBounds = false

        compareContent.layer.shadowColor = UIColor.black.cgColor
        compareContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        compareContent.layer.shadowOpacity = 0.2
        compareContent.layer.shadowRadius = shadowRadius

        compareView.frame = compareView.bounds
        compareView.autoresizingMask = [
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
    private func embedCompareView() {
        addChildViewController(compareVC, toContainerView: compareView)
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        //MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    private var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    private var controlList = [true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
}
