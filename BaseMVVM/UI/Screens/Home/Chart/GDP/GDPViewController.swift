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

class GDPViewController: ViewController {
    
    @IBOutlet weak var compareContent: UIView!
    @IBOutlet weak var compareView: UIView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        
        addCompareViewShadow(cornerRadius: 12.0, shadowRadius: 5.0)
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
    
    // Show ratio view
    private func embedCompareView() {
        addChildViewController(compareVC, toContainerView: compareView)
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        //MBProgressHUD.hide(for: self.view, animated: true)
    }
}
