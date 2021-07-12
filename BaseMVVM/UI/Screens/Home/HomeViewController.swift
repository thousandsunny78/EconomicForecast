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
    @IBOutlet weak var borderBackgroundArea: UIView!
    @IBOutlet weak var dailyboardArea: UIView!
    @IBOutlet weak var dailyboardContentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackContentView: UIView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTab1()
        showDailyBoard()
        addTabbarShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // Call the roundCorners() func right there.
        borderBackgroundArea.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
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
        addShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        currentDailyBoardViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(dailyBoardVC, toContainerView: dailyboardArea)
        currentDailyBoardViewController = dailyBoardVC
    }
    
    // quanth: round and shadow uiview
    private func addShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        dailyboardArea.layer.cornerRadius = cornerRadius
        dailyboardArea.layer.masksToBounds = true

        dailyboardContentView.layer.cornerRadius = cornerRadius
        dailyboardContentView.layer.masksToBounds = false

        dailyboardContentView.layer.shadowColor = UIColor.black.cgColor
        dailyboardContentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        dailyboardContentView.layer.shadowOpacity = 0.2
        dailyboardContentView.layer.shadowRadius = shadowRadius

        dailyboardArea.frame = dailyboardContentView.bounds
        dailyboardArea.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
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
}
