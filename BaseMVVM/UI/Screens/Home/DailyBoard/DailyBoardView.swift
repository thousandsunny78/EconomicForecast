//
//  DailyBoardView.swift
//  BaseMVVM
//
//  Created by Quan on 04/07/2021.
//  Copyright © 2021 thoson.it. All rights reserved.
//

import UIKit

class DailyBoardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var area1: UIView!
    @IBOutlet weak var area2: UIView!
    @IBOutlet weak var area3: UIView!
    @IBOutlet weak var area4: UIView!
    
//    private func setupView(){
//            // load file xib theo tên từ bộ nhớ
//            Bundle.main.loadNibNamed("DailyBoardView", owner: self, options: nil)
//            // add contentView như một subView của view mà mình đã tạo
//            self.addSubview(contentView)
//            // định vị contentView để show full toàn bộ giao diện.
//            contentView.frame = self.bounds
//            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            xibSetup()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            xibSetup()
        }

        func xibSetup() {
            contentView = loadViewFromNib()

            // use bounds not frame or it'll be offset
            contentView.frame = bounds

            // Make the view stretch with containing view
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            // Adding custom subview on top of our view
            addSubview(contentView)
        }

    func loadViewFromNib() -> UIView! {

            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
            let view = nib.instantiate(withOwner: self, options: nil).first as! UIView

            return view
    }

}
