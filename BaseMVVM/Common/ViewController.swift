//
//  BaseViewController.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 1/4/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD
import Charts

class ViewController: UIViewController {
    struct Constants {
        static let CPI_FORECAST: Int = 0
        static let CPI_STATISTICAL: Int = 1
        static let IIP_FORECAST: Int = 2
        static let IIP_STATISTICAL: Int = 3
    }
    
    var viewModel: ViewModel?
    var navigator: Navigator?
    
    let disposeBag = DisposeBag()
    
    let isLoading = BehaviorRelay(value: false)
    
    let emptyDataSetButtonTap = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        bindViewModel()
    }
    
    deinit {
        log.info("\(type(of: self)): Deinited")
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        log.info("\(type(of: self)): Received Memory Warning")
    }
    
    func makeUI() {
        isLoading.subscribe(onNext: {[weak self] (loading) in
            guard let self = self else { return }
            if loading {
                let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
                Indicator?.labelText = "Đang tải..."
                Indicator?.isUserInteractionEnabled = false
                Indicator?.show(true)
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        
    }
}

// MARK: - Setup navigation
extension ViewController {
    //Clear background
    func clearNavigationBackground() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                               for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //Show title
    func setTitle(_ title: String?, subTitle: String?) {
        
        let label = UILabel()
        var titleAttribute: NSMutableAttributedString?
        if let title = title {
            let attributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .heavy),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            titleAttribute = NSMutableAttributedString(string: title,
                                                       attributes: attributes)
        }
        
        var subTitleAttribute: NSMutableAttributedString?
        if let subTitle = subTitle {
            let font = UIFont.systemFont(ofSize: 14, weight: .heavy)
            let attributes = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            subTitleAttribute = NSMutableAttributedString(string: subTitle,
                                                          attributes: attributes)
        }
        
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.textAlignment = .center
        //Muiltible title
        if let titleAttribute = titleAttribute, let subTitleAttribute = subTitleAttribute {
            let textAttribute = NSMutableAttributedString()
            textAttribute.append(titleAttribute)
            let breaklineAttribute = NSMutableAttributedString(string: "\n", attributes: nil)
            textAttribute.append(breaklineAttribute)
            textAttribute.append(subTitleAttribute)
            label.attributedText = textAttribute
            navigationItem.titleView = label
            return
        }
        //Title only
        if let titleAttribute = titleAttribute {
            label.attributedText = titleAttribute
            navigationItem.titleView = label
            return
        }
        //Sub title only
        if let subTitleAttribute = subTitleAttribute {
            label.attributedText = subTitleAttribute
            navigationItem.titleView = label
        }
    }
    
    //Show left/right button
    func showLeftButton(image: UIImage? = nil) {
        var image = image
        if image == nil {
            image = UIImage(named: "ic_back_white")
        }
        navigationController?.navigationBar.tintColor = .white
        let barButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(self.leftButtonTapped(sender:)))
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func hideLeftButton() {
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func showRightButton(image: UIImage? = nil) {
        var image = image
        if image == nil {
            image = UIImage(named: "ic_menu")
            image = image?.withRenderingMode(.alwaysOriginal)
        }
        let barButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(self.rightButtonTapped(sender:)))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func hideRightButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    //Handle left/right button
    @objc func leftButtonTapped(sender: UIBarButtonItem) {
        if let nav = navigationController {
            nav.popViewController(animated: true)
            return
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func rightButtonTapped(sender: UIBarButtonItem) {
        
    }

    
}

extension UISwitch {

    func set(width: CGFloat, height: CGFloat) {

        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}

extension UIButton {

    func roundButton(borderWidth: CGFloat, color: UIColor) {

        let dSize: CGFloat = min(self.frame.height, self.frame.width)
        self.clipsToBounds = true
        self.layer.cornerRadius = dSize/2.0
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
}

extension UIView {

    func roundView(borderWidth: CGFloat, color: UIColor) {

        let dSize: CGFloat = min(self.frame.height, self.frame.width)
        self.clipsToBounds = true
        self.layer.cornerRadius = dSize/2.0
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
}

class BarChartFormatter: NSObject,IAxisValueFormatter,IValueFormatter {


    var values : [String]
    required init (values : [String]) {
        self.values = values
        super.init()
    }


    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return values[Int(value)]
    }

    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return values[Int(entry.x)]
    }
}
