//
//  GDPViewController.swift
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

class GDPViewController: ViewController{
    
    @IBOutlet weak var compareContent: UIView!
    @IBOutlet weak var compareView: UIView!
    @IBOutlet weak var combinedContent: UIView!
    @IBOutlet weak var combinedView: UIView!
    
    private var gdpDatas: [CPIDataEntity] = []
    private var timelines: [String] = []
    private var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    private var controlList = [true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    private lazy var compareVC: ViewController = {
        let viewController = GDPCompareViewController(nibName: GDPCompareViewController.className, bundle: nil)
        let navigator = GDPCompareNavigator(with: viewController)
        let viewModel = GDPCompareViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.iipDatas = gdpDatas
        viewController.timelines = timelines
        return viewController
    }()
    
    private lazy var combinedVC: ViewController = {
        let viewController = CombinedViewController(nibName: CombinedViewController.className, bundle: nil)
        let navigator = CombinedNavigator(with: viewController)
        let viewModel = CombinedViewModel(navigator: navigator)
        viewController.viewModel = viewModel
//        viewController.iipDatas = gdpDatas
//        viewController.timelines = timelines
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        addCompareViewShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addCombinedViewShadow(cornerRadius: 12.0, shadowRadius: 5.0)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? GDPViewModel else { return }
        
        let input = GDPViewModel.Input()
        let output = viewModel.transform(input: input)
        
        // subcribe postal subject
        output.gdpDataSubject.subscribe(onNext: {[weak self] data in
            guard let self = self else { return }
            if(data != nil){
                self.gdpDatas = data?.cpi ?? []
                self.timelines = data?.timeline ?? []
                self.embedCompareView()
                self.embedCombinedView()
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.fetchGDPIndexs()
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
    
    // quanth: round and shadow uiview
    private func addCombinedViewShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        combinedView.layer.cornerRadius = cornerRadius
        combinedView.layer.masksToBounds = true

        combinedContent.layer.cornerRadius = cornerRadius
        combinedContent.layer.masksToBounds = false

        combinedContent.layer.shadowColor = UIColor.black.cgColor
        combinedContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        combinedContent.layer.shadowOpacity = 0.2
        combinedContent.layer.shadowRadius = shadowRadius

        combinedView.frame = combinedView.bounds
        combinedView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
    }
    
    // Show ratio view
    private func embedCompareView() {
        addChildViewController(compareVC, toContainerView: compareView)
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        //MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    // Show ratio view
    private func embedCombinedView() {
        addChildViewController(combinedVC, toContainerView: combinedView)
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        //MBProgressHUD.hide(for: self.view, animated: true)
    }
    
}
