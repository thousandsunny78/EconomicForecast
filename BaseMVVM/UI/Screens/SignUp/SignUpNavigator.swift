//
//  File.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 4/20/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import UIKit

class SignUpNavigator: Navigator {
    func pushHome() {
        let viewController = HomeChartViewController(nibName: HomeChartViewController.className, bundle: nil)
        let navigator = HomeChartNavigator(with: viewController)
        let viewModel = HomeChartViewModel(navigator: navigator)
        viewController.viewModel = viewModel
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] () in
            guard let self = self else { return }
            if let count = self.navigationController?.viewControllers.count, count >= 2 {
                self.navigationController?.viewControllers.removeSubrange(0..<count - 1 )
            }
        }
        navigationController?.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
