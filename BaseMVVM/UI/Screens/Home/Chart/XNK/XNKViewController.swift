//
//  XNKViewController.swift
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

class XNKViewController: ViewController {
    
    @IBOutlet weak var ratioContent: UIView!
    @IBOutlet weak var ratioView: UIView!
    
    private var xnkDatas: [CPIDataEntity] = []
    private var timelines: [String] = []
    
    private lazy var ratioVC: ViewController = {
        let viewController = XNKRatioViewController(nibName: XNKRatioViewController.className, bundle: nil)
        let navigator = XNKRatioNavigator(with: viewController)
        let viewModel = XNKRatioViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        viewController.xnkDatas = xnkDatas
        viewController.timelines = timelines
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        addRatioShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        self.embedRatioView()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? XNKViewModel else { return }
        
        let input = XNKViewModel.Input()
        let output = viewModel.transform(input: input)
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
    
    // Show ratio view
    private func embedRatioView() {
        addChildViewController(ratioVC, toContainerView: ratioView)
        // quanth: vẽ biểu đồ hơn lâu nên chờ vẽ xong mới tắt
        //MBProgressHUD.hide(for: self.view, animated: true)
    }
}
