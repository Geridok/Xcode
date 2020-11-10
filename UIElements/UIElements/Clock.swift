//
//  Clock.swift
//  UIElements
//
//  Created by Vladimir Mustafin on 04.11.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

@IBDesignable
class Line:UIView {
    
    @IBInspectable var lineSize:CGFloat = 5{
        didSet{
            updateFrame()
        }
    }
    
    @IBInspectable var lineOffset:CGFloat = 0{
        didSet{
            updateFrame()
        }
    }
    
    @IBInspectable var color:UIColor = .blue{
        didSet{
            self.backgroundColor = color
        }
    }
    
    func updateTime(time: Int){
        let angle:CGFloat = CGFloat.pi * 2 * (CGFloat(time)/60)
        
        self.transform = CGAffineTransform(rotationAngle: angle)
    }
    private func updateFrame(){
        let w = self.superview?.frame.size.width
        let h = self.superview?.frame.size.height
        self.frame = CGRect(x: w ?? 0/2 - lineSize/2, y: lineOffset, width: lineSize, height: h ?? 0/2 - lineOffset)
    }
}

@IBDesignable
class Clock: UIView {

    var isSetuped = false
    
    var markerSize:CGFloat = 3
    var markerLenght:CGFloat = 12
    var markerColor = UIColor.blue
    
    private let topMarker = UIView()
    private let bottomMarker = UIView()
    private let leftMarker = UIView()
    private let rightMarker = UIView()
    
    @IBInspectable private let hourLine = Line()
    @IBInspectable private let minLine = Line()
    @IBInspectable private let secLine = Line()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = frame.size.width
        let h = frame.size.height
        
        
        hourLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        minLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        secLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        topMarker.frame = CGRect(x: w/2 - markerSize / 2, y: 0, width: markerSize, height: markerLenght)
        bottomMarker.frame = CGRect(x: w/2 - markerSize/2, y: h - markerLenght, width: markerSize, height: markerLenght)
        leftMarker.frame = CGRect(x: 0, y: h/2 - markerSize/2, width: markerLenght, height: markerSize)
        rightMarker.frame = CGRect(x: w - markerLenght, y: h/2 - markerSize/2, width: markerLenght, height: markerSize)
        
        for item in [topMarker,bottomMarker,leftMarker,rightMarker]{
            item.backgroundColor = markerColor
        }
        
        if isSetuped {
            return
        }
        isSetuped = true
        
        layer.cornerRadius = frame.size.width/2
        
        for item in [topMarker,bottomMarker,leftMarker,rightMarker,hourLine,minLine,secLine]{
           addSubview(item)
        }
        hourLine.lineSize = 20
        hourLine.updateTime(time: 10)
        minLine.lineSize = 10
        minLine.updateTime(time: 40)
        secLine.lineSize = 1
    }

}
