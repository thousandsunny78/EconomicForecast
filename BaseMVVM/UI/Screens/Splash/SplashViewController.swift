//
//  ViewController.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 1/4/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import UIKit

class SplashViewController: ViewController {
    
    @IBOutlet var content: UIView!
    override func viewDidLoad() {
        let navigator = SplashNavigator(with: self)
        viewModel = SplashViewModel(navigator: navigator)
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func makeUI() {
        super.makeUI()
        self.content.backgroundColor = UIColor(patternImage: UIImage(named: "ic_background_app")!)
        clearNavigationBackground()
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationController?.navigationItem.hidesBackButton = true
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? SplashViewModel else {
            return
        }
    }
}

