//
//  HomeViewController.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 4/21/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: ViewController {
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak var dailyBoardView: UIView!
    @IBOutlet weak var tab1Button: UIButton!
    @IBOutlet weak var tab2Button: UIButton!
    @IBOutlet weak var dailyboardArea: UIView!
    
    private lazy var tab1VC: ViewController = {
        let viewController = ListViewController(nibName: ListViewController.className, bundle: nil)
        let navigator = ListNavigator(with: viewController)
        let viewModel = ListViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    private lazy var tab2VC: ViewController = {
        let viewController = ListViewController(nibName: ListViewController.className, bundle: nil)
        let navigator = ListNavigator(with: viewController)
        let viewModel = ListViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    private lazy var dailyBoardVC: ViewController = {
        let viewController = DailyBoardViewController(nibName: DailyBoardViewController.className, bundle: nil)
        let navigator = DailyBoardNavigator(with: viewController)
        let viewModel = DailyBoardViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    
    
    var currentViewController: ViewController?
    var currentDailyBoardViewController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTab1()
        showDailyBoard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func makeUI() {
        super.makeUI()
        setTitle("MVVM DEMO",
                 subTitle: "Newwave solution CSJ")
        showLeftButton(image: UIImage(named: "ic_menu"))
        //Setup right button
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(self.rightButtonTapped(sender:)))
        navigationItem.rightBarButtonItem = barButtonItem
        //Setup tabs
        tab1Button.rx.tap.bind { [weak self] () in
            self?.showTab1()
        }.disposed(by: disposeBag)
        tab2Button.rx.tap.bind { [weak self] () in
            self?.showTab2()
        }.disposed(by: disposeBag)
    }

    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? HomeViewModel else { return }
        let menuAction = navigationItem.leftBarButtonItem!.rx.tap.asDriver()
        let logoutAction = navigationItem.rightBarButtonItem!.rx.tap.asDriver()
        let input = HomeViewModel.Input(menuAction: menuAction,
                                        logoutAction: logoutAction)
        let output = viewModel.transform(input: input)
    }
    
    // Show list data
    private func showTab1() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab1VC, toContainerView: containerView)
        currentViewController = tab1VC
        
        tab1Button.backgroundColor = UIColor.App.tabSelected
        tab1Button.setTitleColor(UIColor.App.tabUnselected, for: .normal)
        tab2Button.backgroundColor = UIColor.white
        tab2Button.setTitleColor(UIColor.App.tabSelected, for: .normal)
    }
    
    private func showTab2() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab2VC, toContainerView: containerView)
        currentViewController = tab2VC
        
        tab1Button.backgroundColor = UIColor.white
        tab1Button.setTitleColor(UIColor.App.tabSelected, for: .normal)
        tab2Button.backgroundColor = UIColor.App.tabSelected
        tab2Button.setTitleColor(UIColor.App.tabUnselected, for: .normal)
    }
    
    // Show list data
    private func showDailyBoard() {
        currentDailyBoardViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(dailyBoardVC, toContainerView: dailyboardArea)
        currentDailyBoardViewController = dailyBoardVC
    }
}
