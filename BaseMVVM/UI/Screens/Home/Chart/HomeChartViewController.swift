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
import SideMenu


class HomeChartViewController: ViewController {
    
    @IBOutlet weak var areaVC: UIView!
    @IBOutlet weak var contentVC: UIView!
    
    private var currentViewController: ViewController?
    private var currentDailyBoardViewController: ViewController?
    
    private lazy var tab1VC: ViewController = {
        let viewController = CPIViewController(nibName: CPIViewController.className, bundle: nil)
        let navigator = CPINavigator(with: viewController)
        let viewModel = CPIViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
//    private lazy var tab1VC: ViewController = {
//        let viewController = MenuListViewController(nibName: MenuListViewController.className, bundle: nil)
//        let navigator = MenuListNavigator(with: viewController)
//        let viewModel = MenuListViewModel(navigator: navigator)
//        viewController.viewModel = viewModel
//        return viewController
//    }()
    
    private lazy var tab2VC: ViewController = {
        let viewController = IIPViewController(nibName: IIPViewController.className, bundle: nil)
        let navigator = IIPNavigator(with: viewController)
        let viewModel = IIPViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    private lazy var tab3VC: ViewController = {
        let viewController = GDPViewController(nibName: GDPViewController.className, bundle: nil)
        let navigator = GDPNavigator(with: viewController)
        let viewModel = GDPViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    private lazy var tab4VC: ViewController = {
        let viewController = XNKViewController(nibName: XNKViewController.className, bundle: nil)
        let navigator = XNKNavigator(with: viewController)
        let viewModel = XNKViewModel(navigator: navigator)
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
    
    private lazy var tab6VC: ViewController = {
        let viewController = FinanceViewController(nibName: FinanceViewController.className, bundle: nil)
        let navigator = FinanceNavigator(with: viewController)
        let viewModel = FinanceViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    /// quanth: config menu bên trái
    private lazy var menuVC: MenuListViewController = {
        var viewController: MenuListViewController = MenuListViewController()
        viewController.home = self
        let navigator = MenuListNavigator(with: viewController)
        let viewModel = MenuListViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    /// quanth: config menu bên trái
    private lazy var menu: SideMenuNavigationController = {
        let viewController = SideMenuNavigationController(rootViewController: menuVC)
        return viewController
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /// quanth: tạo left menu
        showLeftButton(image: nil)
        configMenu()
        showTab1()
        
    }
    
    override func makeUI() {
        super.makeUI()
        setTitle("Dự báo kinh tế", subTitle: "")
        showLeftButton(image: UIImage(named: "ic_menu"))
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? HomeChartViewModel else { return }
        let menuAction = navigationItem.leftBarButtonItem!.rx.tap.asDriver()
        let input = HomeChartViewModel.Input(menuAction: menuAction)
        let output = viewModel.transform(input: input)
    }
    
    // Show list data
    func showTab1() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab1VC, toContainerView: areaVC)
        currentViewController = tab1VC
    }
    
    func showTab2() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab2VC, toContainerView: contentVC)
        currentViewController = tab2VC
    }
    
    func showTab3() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab3VC, toContainerView: contentVC)
        currentViewController = tab3VC
    }
    
    func showTab4() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab4VC, toContainerView: contentVC)
        currentViewController = tab4VC
    }
    
    func showTab5() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab5VC, toContainerView: contentVC)
        currentViewController = tab5VC
        
    }
    
    func showTab6() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab6VC, toContainerView: contentVC)
        currentViewController = tab6VC
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
    
    /// config menu
    private func configMenu(){
        menu.leftSide = true
        menu.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    func hideSideMenu(){
        dismiss(animated: true, completion: nil)
    }
    
    override func leftButtonTapped(sender: UIBarButtonItem) {
        present(menu, animated: true, completion: nil)
    }
    
    func logout() {
        (self.viewModel as? HomeChartViewModel)?.logout()
    }
}

