//
//  HomeChartViewController.swift
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


class HomeChartViewController: ViewController {
    
    @IBOutlet weak var tab1VCContentView: UIView!
    @IBOutlet weak var tab1VCButton: UIButton!
    @IBOutlet weak var tab2VCContentView: UIView!
    @IBOutlet weak var tab2VCButton: UIButton!
    @IBOutlet weak var tab3VCContentView: UIView!
    @IBOutlet weak var tab3VCButton: UIButton!
    @IBOutlet weak var tab4VCContentView: UIView!
    @IBOutlet weak var tab4VCButton: UIButton!
    @IBOutlet weak var tab5VCContentView: UIView!
    @IBOutlet weak var tab5VCButton: UIButton!
    @IBOutlet weak var tab6VCContentView: UIView!
    @IBOutlet weak var tab6VCButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackContentView: UIView!
    @IBOutlet weak var areaVC: UIView!
    @IBOutlet weak var contentVC: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    private var currentViewController: ViewController?
    private var currentDailyBoardViewController: ViewController?
    
    private lazy var tab1VC: ViewController = {
        let viewController = CPIViewController(nibName: CPIViewController.className, bundle: nil)
        let navigator = CPINavigator(with: viewController)
        let viewModel = CPIViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    private lazy var tab2VC: ViewController = {
        let viewController = IIPViewController(nibName: IIPViewController.className, bundle: nil)
        let navigator = IIPNavigator(with: viewController)
        let viewModel = IIPViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    private lazy var tab5VC: ViewController = {
        let viewController = UnemploymentViewController(nibName: UnemploymentViewController.className, bundle: nil)
        let navigator = UnemploymentNavigator(with: viewController)
        let viewModel = UnemploymentViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showTab1()
        //addShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        //addTabbarShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addtab1Shadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addtab2Shadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addtab3Shadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addtab4Shadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addtab5Shadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addtab6Shadow(cornerRadius: 12.0, shadowRadius: 5.0)
        
    }
    
    override func makeUI() {
        super.makeUI()
        setTitle("Dự báo kinh tế", subTitle: "")
        showLeftButton(image: UIImage(named: "ic_menu"))
        // quanth: tắt phần background trắng lúc overscroll
        scrollView.backgroundColor = UIColor.App.tabUnselected
        // quanth: hide scrollbar của scrollview
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        //Setup right button
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(self.rightButtonTapped(sender:)))
        navigationItem.rightBarButtonItem = barButtonItem
        //Setup tabs
        tab1VCButton.rx.tap.bind { [weak self] () in
            self?.showTab1()
        }.disposed(by: disposeBag)
        tab2VCButton.rx.tap.bind { [weak self] () in
            self?.showTab2()
        }.disposed(by: disposeBag)
        tab5VCButton.rx.tap.bind { [weak self] () in
            self?.showTab5()
        }.disposed(by: disposeBag)
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? HomeChartViewModel else { return }
        let menuAction = navigationItem.leftBarButtonItem!.rx.tap.asDriver()
        let logoutAction = navigationItem.rightBarButtonItem!.rx.tap.asDriver()
        let input = HomeChartViewModel.Input(menuAction: menuAction,
                                        logoutAction: logoutAction)
        let output = viewModel.transform(input: input)
    }
    
    // Show list data
    private func showTab1() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab1VC, toContainerView: areaVC)
        currentViewController = tab1VC
        
        tab1VCButton.backgroundColor = UIColor.App.tabSelected
        tab1VCButton.setTitleColor(UIColor.App.tabUnselected, for: .normal)
        tab2VCButton.backgroundColor = UIColor.white
        tab2VCButton.setTitleColor(UIColor.App.tabSelected, for: .normal)
        tab5VCButton.backgroundColor = UIColor.white
        tab5VCButton.setTitleColor(UIColor.App.tabSelected, for: .normal)
    }
    
    private func showTab2() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab2VC, toContainerView: contentVC)
        currentViewController = tab2VC
        
        tab1VCButton.backgroundColor = UIColor.white
        tab1VCButton.setTitleColor(UIColor.App.tabSelected, for: .normal)
        tab2VCButton.backgroundColor = UIColor.App.tabSelected
        tab2VCButton.setTitleColor(UIColor.App.tabUnselected, for: .normal)
        tab5VCButton.backgroundColor = UIColor.white
        tab5VCButton.setTitleColor(UIColor.App.tabSelected, for: .normal)
    }
    
    private func showTab5() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab5VC, toContainerView: contentVC)
        currentViewController = tab5VC
        
        tab5VCButton.backgroundColor = UIColor.App.tabSelected
        tab5VCButton.setTitleColor(UIColor.App.tabUnselected, for: .normal)
        tab1VCButton.backgroundColor = UIColor.white
        tab1VCButton.setTitleColor(UIColor.App.tabSelected, for: .normal)
        tab2VCButton.backgroundColor = UIColor.white
        tab2VCButton.setTitleColor(UIColor.App.tabSelected, for: .normal)
    }
    
    // quanth: round and shadow uiview
    private func addTabbarShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        stackView.layer.cornerRadius = cornerRadius
        stackView.layer.masksToBounds = true

        stackContentView.layer.cornerRadius = cornerRadius
        stackContentView.layer.masksToBounds = false

        stackContentView.layer.shadowColor = UIColor.black.cgColor
        stackContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        stackContentView.layer.shadowOpacity = 0.2
        stackContentView.layer.shadowRadius = shadowRadius

        stackView.frame = stackContentView.bounds
        stackView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
    
    // quanth: round and shadow uiview
    private func addShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        areaVC.layer.cornerRadius = cornerRadius
        areaVC.layer.masksToBounds = true

        contentVC.layer.cornerRadius = cornerRadius
        contentVC.layer.masksToBounds = false

        contentVC.layer.shadowColor = UIColor.black.cgColor
        contentVC.layer.shadowOffset = CGSize(width: 1, height: 1)
        contentVC.layer.shadowOpacity = 0.2
        contentVC.layer.shadowRadius = shadowRadius

        areaVC.frame = contentVC.bounds
        areaVC.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
    
    // quanth: round and shadow uiview
    private func addtab1Shadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        tab1VCButton.layer.cornerRadius = cornerRadius
        tab1VCButton.layer.masksToBounds = true

        tab1VCContentView.layer.cornerRadius = cornerRadius
        tab1VCContentView.layer.masksToBounds = false

        tab1VCContentView.layer.shadowColor = UIColor.black.cgColor
        tab1VCContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        tab1VCContentView.layer.shadowOpacity = 0.2
        tab1VCContentView.layer.shadowRadius = shadowRadius

        tab1VCButton.frame = tab1VCContentView.bounds
        tab1VCButton.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
    
    // quanth: round and shadow uiview
    private func addtab2Shadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        tab2VCButton.layer.cornerRadius = cornerRadius
        tab2VCButton.layer.masksToBounds = true

        tab2VCContentView.layer.cornerRadius = cornerRadius
        tab2VCContentView.layer.masksToBounds = false

        tab2VCContentView.layer.shadowColor = UIColor.black.cgColor
        tab2VCContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        tab2VCContentView.layer.shadowOpacity = 0.2
        tab2VCContentView.layer.shadowRadius = shadowRadius

        tab2VCButton.frame = tab2VCContentView.bounds
        tab2VCButton.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
    
    // quanth: round and shadow uiview
    private func addtab3Shadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        tab3VCButton.layer.cornerRadius = cornerRadius
        tab3VCButton.layer.masksToBounds = true

        tab3VCContentView.layer.cornerRadius = cornerRadius
        tab3VCContentView.layer.masksToBounds = false

        tab3VCContentView.layer.shadowColor = UIColor.black.cgColor
        tab3VCContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        tab3VCContentView.layer.shadowOpacity = 0.2
        tab3VCContentView.layer.shadowRadius = shadowRadius

        tab3VCButton.frame = tab3VCContentView.bounds
        tab3VCButton.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
    
    // quanth: round and shadow uiview
    private func addtab4Shadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        tab4VCButton.layer.cornerRadius = cornerRadius
        tab4VCButton.layer.masksToBounds = true

        tab4VCContentView.layer.cornerRadius = cornerRadius
        tab4VCContentView.layer.masksToBounds = false

        tab4VCContentView.layer.shadowColor = UIColor.black.cgColor
        tab4VCContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        tab4VCContentView.layer.shadowOpacity = 0.2
        tab4VCContentView.layer.shadowRadius = shadowRadius

        tab4VCButton.frame = tab4VCContentView.bounds
        tab4VCButton.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
    
    // quanth: round and shadow uiview
    private func addtab5Shadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        tab5VCButton.layer.cornerRadius = cornerRadius
        tab5VCButton.layer.masksToBounds = true

        tab5VCContentView.layer.cornerRadius = cornerRadius
        tab5VCContentView.layer.masksToBounds = false

        tab5VCContentView.layer.shadowColor = UIColor.black.cgColor
        tab5VCContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        tab5VCContentView.layer.shadowOpacity = 0.2
        tab5VCContentView.layer.shadowRadius = shadowRadius

        tab5VCButton.frame = tab5VCContentView.bounds
        tab5VCButton.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
    
    // quanth: round and shadow uiview
    private func addtab6Shadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        tab6VCButton.layer.cornerRadius = cornerRadius
        tab6VCButton.layer.masksToBounds = true

        tab6VCContentView.layer.cornerRadius = cornerRadius
        tab6VCContentView.layer.masksToBounds = false

        tab6VCContentView.layer.shadowColor = UIColor.black.cgColor
        tab6VCContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        tab6VCContentView.layer.shadowOpacity = 0.2
        tab6VCContentView.layer.shadowRadius = shadowRadius

        tab6VCButton.frame = tab6VCContentView.bounds
        tab6VCButton.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
}
