//
//  PaddleView.swift
//  breakout
//
//  Created by Lukas Paluch on 20.01.17.
//  Copyright © 2017 Lukas Paluch. All rights reserved.
//

import UIKit

class CurvedView: UIView {
    
    
    override func draw(_ rect: CGRect) {
        
        let y:CGFloat = 20
        let curveTo:CGFloat = 0
        
        let myBezier = UIBezierPath()
        myBezier.move(to: CGPoint(x: 0, y: y))
        myBezier.addQuadCurve(to: CGPoint(x: rect.width, y: y), controlPoint: CGPoint(x: rect.width / 2, y: curveTo))
        myBezier.addLine(to: CGPoint(x: rect.width, y: rect.height))
        myBezier.addLine(to: CGPoint(x: 0, y: rect.height))
        myBezier.close()
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(4.0)
        UIColor.white.setFill()
        myBezier.fill()
    }
}
