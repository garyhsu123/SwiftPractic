//
//  PushButton.swift
//  SwiftXibPractice
//
//  Created by Yu-Chun Hsu on 2021/5/4.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import UIKit



@IBDesignable
class PushButton: UIButton {

    @IBInspectable var fillColor: UIColor = .green
    @IBInspectable var isAddButton: Bool = false
    
    private struct Constants {
      static let plusLineWidth: CGFloat = 3.0
      static let plusButtonScale: CGFloat = 0.6
      static let halfPointShift: CGFloat = 0.5
    }
      
    private var halfWidth: CGFloat {
      return bounds.width / 2
    }
      
    private var halfHeight: CGFloat {
      return bounds.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        // Drawing code
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        //set up the width and height variables
        //for the horizontal stroke
        let plusWidth = min(bounds.width, bounds.height)
          * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2

        //create the path
        let plusPath = UIBezierPath()

        //set the path's line width to the height of the stroke
        plusPath.lineWidth = Constants.plusLineWidth

        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.move(to: CGPoint(
          x: halfWidth - halfPlusWidth,
          y: halfHeight))

        //add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
          x: halfWidth + halfPlusWidth,
          y: halfHeight))

        //Vertical Line
         
        if (isAddButton) {
            plusPath.move(to: CGPoint(
              x: halfWidth + Constants.halfPointShift,
              y: halfHeight - halfPlusWidth + Constants.halfPointShift))
                  
            plusPath.addLine(to: CGPoint(
              x: halfWidth + Constants.halfPointShift,
              y: halfHeight + halfPlusWidth + Constants.halfPointShift))
        }
        
        //set the stroke color
        UIColor.white.setStroke()

        //draw the stroke
        plusPath.stroke()
        
    }
    

}
