//
//  IIPItemViewController.swift
//  BaseMVVM
//
//  Created by Quan on 13/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa

class IIPItemViewController: ViewController {
    
    // MARK: View lifecycle
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var switchVC: UISwitch!
    @IBOutlet weak var lineVC: UIView!
    
    var entity: ChartControlEntity = ChartControlEntity(color: UIColor.red, content: "no title", isOn: false)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        resizeSwitch()
        initUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? IIPItemViewModel else { return }
        
        let input = IIPItemViewModel.Input()
        let output = viewModel.transform(input: input)
    }
    
    private func initUI(){
        label.text = entity.content
        switchVC.isOn = entity.isOn
        lineVC.backgroundColor = entity.color
    }
    
    func updateUI(entity: ChartControlEntity){
        self.entity = entity
        initUI()
    }
    
    private func resizeSwitch(){
        switchVC.set(width: 30, height: 20)
    }
    
}
