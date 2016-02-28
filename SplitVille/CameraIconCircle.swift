//
//  CameraIconCircle.swift
//  SplitVille
//
//  Created by Nabil Maadarani on 2016-02-27.
//  Copyright © 2016 Nabil. All rights reserved.
//

import UIKit
import GLKit

class CameraIconCircle: UIView {

    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(arcCenter: CGPoint(x: rect.width/2, y: rect.height/2),
            radius: rect.width/2 - 1,
            startAngle: CGFloat(GLKMathDegreesToRadians(0.0)),
            endAngle: CGFloat(GLKMathDegreesToRadians(360.0)),
            clockwise: true)
        
        UIColor.whiteColor().setStroke()
        path.stroke()
        
        UIColor.clearColor().setFill()
        path.fill()
    }

}
