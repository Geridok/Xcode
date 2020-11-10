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
    
    
    @IBInspectable var borderThinkness: CGFloat = 5 {
        didSet {
            self.layer.borderWidth = borderThinkness
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet{
            self.layer.borderColor = borderColor.cgColor
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
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderThinkness
        updateFrame()
    }
    
    private func updateFrame(){
        self.frame.size.width = width
        self.frame.size.height = height
        self.layer.cornerRadius = corner
        self.backgroundColor = Color
    }
}
