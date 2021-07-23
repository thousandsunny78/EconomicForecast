//
//  CPICollectionViewCell.swift
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
import ObjectMapper

class CPICollectionViewCell: CollectionViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func bind(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? CPICellViewModel else {
            return
        }
        if(self.myLabel != nil){
            viewModel.title.bind(to: self.myLabel.rx.text).disposed(by: disposeBag)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

class CPIItem: Mappable {
    required init?(map: Map) {
        // do nothing
    }
    
    var name: String = ""
    
    
    required init?(name: String) {
        self.name = name
    }
    
    func mapping(map: Map) {
        name <- map["name"]
    }
}
