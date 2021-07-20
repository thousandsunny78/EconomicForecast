//
//  MenuListTableViewCell.swift
//  BaseMVVM
//
//  Created by Quan on 20/07/2021.
//  Copyright (c) 2021 thoson.it. All rights reserved.
//
//  Template by: Quan
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class MenuListTableViewCell: TableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    override func bind(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? MenuListCellViewModel else {
            return
        }
//        let item: viewModel
        viewModel.title.bind(to: label.rx.text).disposed(by: disposeBag)
        viewModel.image.bind(to: iconView.rx.image).disposed(by: disposeBag)
    }
}

class MenuItem: Mappable {
    required init?(map: Map) {
        // do nothing
    }
    
    var image: UIImage? = nil
    var name: String = ""
    
    
    required init?(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
    
    func mapping(map: Map) {
        image   <- map["iconView"]
        name <- map["name"]
    }
}


