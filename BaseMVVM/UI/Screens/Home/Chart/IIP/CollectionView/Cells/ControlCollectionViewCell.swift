//
//  ControlCollectionViewCell.swift
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

class ControlCollectionViewCell: CollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func bind(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? ControlCellViewModel else {
            return
        }
    }
}
