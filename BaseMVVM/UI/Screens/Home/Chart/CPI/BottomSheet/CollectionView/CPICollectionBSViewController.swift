//
//  CPICollectionBSViewController.swift
//  BaseMVVM
//
//  Created by Quan on 22/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa

class CPICollectionBSViewController: ViewController {
    
    let reuseIdentifier = "CPICollectionViewCell" // also enter this string as the cell identifier in the storyboard
        var items1 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    private let margin:CGFloat = 16.0
    private let interitemSpacing:CGFloat = 20.0
    private let lineSpacing:CGFloat = 20.0
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        //Register cell
        collectionView.register(CPICollectionViewCell.self, forCellWithReuseIdentifier: CPICollectionViewCell.className)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = self.viewModel as? CPICollectionBSViewModel else { return }
        
        let input = CPICollectionBSViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.items.asDriver(onErrorJustReturn: [])
            .drive(self.collectionView.rx.items(cellIdentifier: CPICollectionViewCell.className, cellType: CPICollectionViewCell.self)) { collectionView, viewModel, cell in
                cell.bind(viewModel: viewModel)
            }.disposed(by: self.disposeBag)
    }
}





