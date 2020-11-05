//
//  CustomButton.swift
//  UIElements
//
//  Created by Vladimir Mustafin on 05.11.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    var isSetuped = false
    
    let substrate = UIView()
    
    @IBInspectable var thicknessOfStroke: CGFloat = 10 {
        didSet {
            updateSubstrate()
        }
    }
    
    @IBInspectable var strokeColor: UIColor = .black {
        didSet{
            updateSubstrate()
        }
    }
    
    @IBInspectable var width:CGFloat = 60 {
        didSet{
            updateFrame()
        }
    }
    
    @IBInspectable var height:CGFloat = 60 {
        didSet{
            updateFrame()
        }
    }
    
    @IBInspectable var Color: UIColor = .blue{
        didSet{
            layoutIfNeeded()
        }
    }
    
    @IBInspectable var corner: CGFloat = 10 {
        didSet{
            updateFrame()
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        
        
        if isSetuped {
            return
        }
        isSetuped = true
        
        updateSubstrate()
        addSubview(substrate)
        
        self.frame.size.width = width
        self.frame.size.height = height
        self.layer.cornerRadius = corner
        self.backgroundColor = Color
        sendSubviewToBack(substrate)
        substrate.alpha = 0
    }
    
    private func updateFrame(){
        self.frame.size.width = width
        self.frame.size.height = height
        self.layer.cornerRadius = corner
        updateSubstrate()
    }
    private func updateSubstrate(){
        substrate.frame = CGRect(x: -thicknessOfStroke/2, y: -thicknessOfStroke/2, width: width + thicknessOfStroke, height: height + thicknessOfStroke)
        substrate.backgroundColor = strokeColor
        substrate.layer.cornerRadius = corner
    }
}
