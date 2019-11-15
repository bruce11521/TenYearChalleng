//
//  SharpImageView.swift
//  TenYearChalleng
//
//  Created by 林伯翰 on 2019/11/15.
//  Copyright © 2019 Bruce Lin. All rights reserved.
//

import UIKit

class SharpImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.height*0.85))
        path.close()
        let shapeLayout = CAShapeLayer()
        shapeLayout.path = path.cgPath
        layer.mask = shapeLayout
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
