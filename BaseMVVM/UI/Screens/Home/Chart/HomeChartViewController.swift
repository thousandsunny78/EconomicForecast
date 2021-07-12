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
    
    @IBOutlet weak var tab1VCButton: UIButton!
    @IBOutlet weak var tab2VCButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackContentView: UIView!
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
    
    private lazy var tab2VC: ViewController = {
        let viewController = ListViewController(nibName: ListViewController.className, bundle: nil)
        let navigator = ListNavigator(with: viewController)
        let viewModel = ListViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showTab1()
        //addShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        addTabbarShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        
    }
    
    override func makeUI() {
        super.makeUI()
        setTitle("Dự báo kinh tế", subTitle: "")
        showLeftButton(image: UIImage(named: "ic_menu"))
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
    
//        aSwitch.rx
//            .controlEvent(.valueChanged)
//            .withLatestFrom(aSwitch.rx.value)
//            .subscribe(onNext : { bool in
//                if(self.currentViewController == self.tab1VC){
//                    (self.tab1VC as! CPIViewController).updateSwitch(index: 0, value: bool)
//                }
//            }).disposed(by: disposeBag)
//        bSwitch.rx
//            .controlEvent(.valueChanged)
//            .withLatestFrom(bSwitch.rx.value)
//            .subscribe(onNext : { bool in
//                if(self.currentViewController == self.tab1VC){
//                    (self.tab1VC as! CPIViewController).updateSwitch(index: 4, value: bool)
//                }
//            }).disposed(by: disposeBag)
//        cSwitch.rx
//            .controlEvent(.valueChanged)
//            .withLatestFrom(cSwitch.rx.value)
//            .subscribe(onNext : { bool in
//                if(self.currentViewController == self.tab1VC){
//                    (self.tab1VC as! CPIViewController).updateSwitch(index: 1, value: bool)
//                }
//            }).disposed(by: disposeBag)
//        dSwitch.rx
//            .controlEvent(.valueChanged)
//            .withLatestFrom(dSwitch.rx.value)
//            .subscribe(onNext : { bool in
//                if(self.currentViewController == self.tab1VC){
//                    (self.tab1VC as! CPIViewController).updateSwitch(index: 5, value: bool)
//                }
//            }).disposed(by: disposeBag)
//        eSwitch.rx
//            .controlEvent(.valueChanged)
//            .withLatestFrom(eSwitch.rx.value)
//            .subscribe(onNext : { bool in
//                if(self.currentViewController == self.tab1VC){
//                    (self.tab1VC as! CPIViewController).updateSwitch(index: 2, value: bool)
//                }
//            }).disposed(by: disposeBag)
//        fSwitch.rx
//            .controlEvent(.valueChanged)
//            .withLatestFrom(fSwitch.rx.value)
//            .subscribe(onNext : { bool in
//                if(self.currentViewController == self.tab1VC){
//                    (self.tab1VC as! CPIViewController).updateSwitch(index: 3, value: bool)
//                }
//            }).disposed(by: disposeBag)
        
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
    }
    
    private func showTab2() {
        currentViewController?.removeViewAndControllerFromParentViewController()
        addChildViewController(tab2VC, toContainerView: contentVC)
        currentViewController = tab2VC
        
        tab1VCButton.backgroundColor = UIColor.white
        tab1VCButton.setTitleColor(UIColor.App.tabSelected, for: .normal)
        tab2VCButton.backgroundColor = UIColor.App.tabSelected
        tab2VCButton.setTitleColor(UIColor.App.tabUnselected, for: .normal)
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
}
