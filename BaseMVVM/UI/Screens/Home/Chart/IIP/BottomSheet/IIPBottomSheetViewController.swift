//
//  IIPBottomSheetViewController.swift
//  BaseMVVM
//
//  Created by Quan on 18/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa

class IIPBottomSheetViewController: ViewController {
    
    @IBOutlet weak var areaVC1: UIView!
    @IBOutlet weak var areaVC2: UIView!
    @IBOutlet weak var areaVC3: UIView!
    @IBOutlet weak var areaVC4: UIView!
    @IBOutlet weak var areaVC5: UIView!
    @IBOutlet weak var areaVC6: UIView!
    @IBOutlet weak var areaVC7: UIView!
    @IBOutlet weak var areaVC8: UIView!
    @IBOutlet weak var areaVC9: UIView!
    @IBOutlet weak var areaVC10: UIView!
    @IBOutlet weak var areaVC11: UIView!
    @IBOutlet weak var areaVC12: UIView!
    @IBOutlet weak var areaVC13: UIView!
    @IBOutlet weak var areaVC14: UIView!
    @IBOutlet weak var areaVC15: UIView!
    
    var iipDatas: [CPIDataEntity] = []
    var iipVC: ViewController? = nil
    var type: Int? = -1
    
    var controlList = [true, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        drawControllBoard()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? IIPBottomSheetViewModel else { return }
        
        let input = IIPBottomSheetViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    // Show list data
    private func drawControllBoard() {
        createControlList(areaVC: areaVC1, entity: ChartControlEntity(color: UIColor.red, content: iipDatas[0].name, isOn: controlList[0], index: 0)!)
        createControlList(areaVC: areaVC2, entity: ChartControlEntity(color: UIColor.blue, content: iipDatas[1].name, isOn: controlList[1], index: 1)!)
        createControlList(areaVC: areaVC3, entity: ChartControlEntity(color: UIColor.green, content: iipDatas[2].name, isOn: controlList[2], index: 2)!)
        createControlList(areaVC: areaVC4, entity: ChartControlEntity(color: UIColor.yellow, content: iipDatas[3].name, isOn: controlList[3], index: 3)!)
        createControlList(areaVC: areaVC5, entity: ChartControlEntity(color: UIColor.brown, content: iipDatas[4].name, isOn: controlList[4], index: 4)!)
        createControlList(areaVC: areaVC6, entity: ChartControlEntity(color: UIColor.purple, content: iipDatas[5].name, isOn: controlList[5], index: 5)!)
        createControlList(areaVC: areaVC7, entity: ChartControlEntity(color: UIColor.orange, content: iipDatas[6].name, isOn: controlList[6], index: 6)!)
        createControlList(areaVC: areaVC8, entity: ChartControlEntity(color: UIColor.black, content: iipDatas[7].name, isOn: controlList[7], index: 7)!)
        createControlList(areaVC: areaVC9, entity: ChartControlEntity(color: UIColor.lightGray, content: iipDatas[8].name, isOn: controlList[8], index: 8)!)
        createControlList(areaVC: areaVC10, entity: ChartControlEntity(color: UIColor.cyan, content: iipDatas[9].name, isOn: controlList[9], index: 9)!)
        createControlList(areaVC: areaVC11, entity: ChartControlEntity(color: UIColor.red, content: iipDatas[10].name, isOn: controlList[10], index: 10)!)
        createControlList(areaVC: areaVC12, entity: ChartControlEntity(color: UIColor.green, content: iipDatas[11].name, isOn: controlList[11], index: 11)!)
        createControlList(areaVC: areaVC13, entity: ChartControlEntity(color: UIColor.purple, content: iipDatas[12].name, isOn: controlList[12], index: 12)!)
        createControlList(areaVC: areaVC14, entity: ChartControlEntity(color: UIColor.yellow, content: iipDatas[13].name, isOn: controlList[13], index: 13)!)
        createControlList(areaVC: areaVC15, entity: ChartControlEntity(color: UIColor.systemBlue, content: iipDatas[14].name, isOn: controlList[14], index: 14)!)
    }
    
    private func createControlList(areaVC: UIView!, entity: ChartControlEntity){
        let controllBoardVC: ViewController = {
            let vc = IIPItemViewController(nibName: IIPItemViewController.className, bundle: nil)
            let navigator = IIPItemNavigator(with: vc)
            let viewModel = IIPItemViewModel(navigator: navigator)
            vc.viewModel = viewModel
            vc.entity = entity
            vc.iipVC = self
            return vc
        }()
        
        addChildViewController(controllBoardVC, toContainerView: areaVC)
        
    }
    
    func updateSwitch(index: Int, value: Bool){
        switch type {
        case Constants.CPI_FORECAST:
            print("do nothing")
        case Constants.CPI_STATISTICAL:
            print("do nothing")
        case Constants.IIP_FORECAST:
            (iipVC as! IIPForecastViewController).updateSwitch(index: index, value: value)
        case Constants.IIP_FORECAST:
            (iipVC as! IIPStatisticalViewController).updateSwitch(index: index, value: value)
            for i in 0..<controlList.count {
                controlList[i] = false
            }
            controlList[index] = value
            drawControllBoard()
        default:
            print("do nothing")
        }
        
    }
}
