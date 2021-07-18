//
//  CPIItemViewController.swift
//  BaseMVVM
//
//  Created by Quan on 14/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa

class CPIItemViewController: ViewController {
    
    // MARK: View lifecycle
    @IBOutlet weak var lineVC: UIView!
    @IBOutlet weak var label: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var areaView: UIView!
    
    var entity: ChartControlEntity = ChartControlEntity(color: UIColor.red, content: "no title", isOn: false, index: -1)!
    var cpiVC: CPIBottomSheetViewController? = nil
    var isOn: Bool = false
    var clickSubject = PublishSubject<(Int, Bool)>()
    var type: Int? = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        initUI()
        if type == Constants.CPI_STATISTICAL {
            bindSingleTapEvent()
        } else {
            bindTapEvent()
        }
        
        clickSubject.subscribe (onNext: {[weak self] (index, isOn) in
            guard let self = self else { return }
            if index == self.entity.index {
                if isOn == false {
                    self.unSelectItem()
                } else {
                    self.selectItem()
                }
                self.isOn = isOn
            }
        }).disposed(by: disposeBag)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? IIPItemViewModel else { return }
        
        let input = IIPItemViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    private func initUI(){
        configButton()
        addShadow(cornerRadius: 12.0, shadowRadius: 5.0)
        label.setTitle(entity.content, for: .normal)
        lineVC.backgroundColor = entity.color
        if(entity.isOn){
            selectItem()
        } else {
            unSelectItem()
        }
    }
    
    func updateUI(entity: ChartControlEntity){
        self.entity = entity
        initUI()
    }
    
    private func bindTapEvent(){
        label.rx.tap.bind { [weak self] () in
            if self?.isOn == true {
                self?.cpiVC?.updateSwitch(index: self?.entity.index ?? -1, value: false)
                self?.unSelectItem()
                self?.isOn = false
            } else {
                self?.cpiVC?.updateSwitch(index: self?.entity.index ?? -1, value: true)
                self?.selectItem()
                self?.isOn = true
            }
        }.disposed(by: disposeBag)
    }
    
    private func bindSingleTapEvent(){
        label.rx.tap.bind { [weak self] () in
            if self?.isOn == false {
                self?.cpiVC?.updateSwitch(index: self?.entity.index ?? -1, value: true)
                self?.selectItem()
                self?.isOn = true
            }
        }.disposed(by: disposeBag)
    }
    
    private func unSelectItem(){
        contentView.backgroundColor = UIColor.white
        label.setTitleColor(UIColor.App.tabSelected, for: .normal)
    }
    
    private func selectItem(){
        contentView.backgroundColor = UIColor.App.tabSelected.withAlphaComponent(0.1)
        label.setTitleColor(UIColor.App.tabSelected, for: .normal)
    }
    
    private func configButton(){
        label.titleLabel?.textAlignment = .center
    }
    
    // quanth: round and shadow uiview
    private func addShadow(cornerRadius: CGFloat, shadowRadius: CGFloat){
        areaView.layer.cornerRadius = 0.0
        areaView.layer.masksToBounds = true

        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = false

        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = shadowRadius

        areaView.frame = contentView.bounds
        areaView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
    }
}
