//
//  BalloonMarker.swift
//  BaseMVVM
//
//  Created by Quan on 14/07/2021.
//  Copyright © 2021 thoson.it. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
import Charts


class BalloonMarker: MarkerView {
    private var text = String()

    private let drawAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 15),
        .foregroundColor: UIColor.App.tabSelected,
        .backgroundColor: UIColor.white
    ]

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        text = String(entry.y)
    }

    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)

        let sizeForDrawing = text.size(withAttributes: drawAttributes)
        bounds.size = sizeForDrawing
        offset = CGPoint(x: -sizeForDrawing.width / 2, y: -sizeForDrawing.height - 4)

        let offset = offsetForDrawing(atPoint: point)
        let originPoint = CGPoint(x: point.x + offset.x, y: point.y + offset.y)
        let rectForText = CGRect(origin: originPoint, size: sizeForDrawing)
        drawText(text: text, rect: rectForText, withAttributes: drawAttributes)
    }

    private func drawText(text: String, rect: CGRect, withAttributes attributes: [NSAttributedString.Key: Any]? = nil) {
        let size = bounds.size
        let centeredRect = CGRect(
            x: rect.origin.x + (rect.size.width - size.width) / 2,
            y: rect.origin.y + (rect.size.height - size.height) / 2,
            width: size.width,
            height: size.height
        )
        text.draw(in: centeredRect, withAttributes: attributes)
    }
}
