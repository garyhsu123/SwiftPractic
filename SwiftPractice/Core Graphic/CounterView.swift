//
//  CounterView.swift
//  SwiftXibPractice
//
//  Created by Yu-Chun Hsu on 2021/5/5.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import UIKit



@IBDesignable
class CounterView: UIView {
    
    private struct Constants {
        static let numberOfGlasses = 8
        static let lineWidth: CGFloat = 5.0
        static let arcWidth: CGFloat = 76

        static var halfOfLineWidth: CGFloat {
          return lineWidth / 2
        }
    }
    
    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <=  maxNumberOfGlasses {
                  //the view needs to be refreshed
                  setNeedsDisplay()
            }
        }
    }
    var maxNumberOfGlasses: Int {
        get {
            Constants.numberOfGlasses
        }
    }
    
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
  
    override func draw(_ rect: CGRect) {
       
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = 1 * .pi / 4
        
        let center = CGPoint.init(x: bounds.width/2, y: bounds.height/2)
        
        let diameter = min(bounds.width, bounds.height)
        
        let path = UIBezierPath.init(arcCenter: center, radius: diameter/2 - Constants.arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.lineWidth = Constants.arcWidth
        counterColor.setStroke()
        path.stroke()
        
        // Draw the outline
        let differenceAngle: CGFloat = 2 * .pi - startAngle + endAngle
        let outLineEndAngle: CGFloat = startAngle + differenceAngle * CGFloat(counter) / CGFloat(maxNumberOfGlasses)
        
        let outlinerPath = UIBezierPath.init(arcCenter: center, radius: bounds.width/2.0 - Constants.halfOfLineWidth, startAngle: startAngle, endAngle: outLineEndAngle, clockwise: true)
        
        outlinerPath.addArc(withCenter: center, radius: bounds.width/2.0 - Constants.arcWidth + Constants.halfOfLineWidth, startAngle: outLineEndAngle, endAngle: startAngle, clockwise: false)
        outlinerPath.close()
        
        outlinerPath.lineWidth = Constants.lineWidth
        outlineColor.setStroke()
        outlinerPath.stroke()
    }
}
