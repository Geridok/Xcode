//
//  Clock.swift
//  UIElements
//
//  Created by Vladimir Mustafin on 04.11.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

@IBDesignable
class Clock: UIView {

    var isSetuped = false
    
    var markerSize:CGFloat = 3
    var markerLenght:CGFloat = 12
    var markerColor = UIColor.blue
    
    
    var hourLineSize:CGFloat = 6
    var hourColor = UIColor.blue
    
    var hours:CGFloat = 0 {
        didSet{
            updateHours()
        }
    }
    
    private let topMarker = UIView()
    private let bottomMarker = UIView()
    private let leftMarker = UIView()
    private let rightMarker = UIView()
    
    private let hourLine = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        hourLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        let w = frame.size.width
        let h = frame.size.height
        
        topMarker.frame = CGRect(x: w/2 - markerSize / 2, y: 0, width: markerSize, height: markerLenght)
        bottomMarker.frame = CGRect(x: w/2 - markerSize/2, y: h - markerLenght, width: markerSize, height: markerLenght)
        leftMarker.frame = CGRect(x: 0, y: h/2 - markerSize/2, width: markerLenght, height: markerSize)
        rightMarker.frame = CGRect(x: w - markerLenght, y: h/2 - markerSize/2, width: markerLenght, height: markerSize)
        
        
        hourLine.frame = CGRect(x: w/2 - hourLineSize/2, y: 0, width: hourLineSize, height: h/2)
        hourLine.backgroundColor = hourColor
        hourLine.layer.cornerRadius = 15
        
        updateHours()
        
        for marker in [topMarker,bottomMarker,leftMarker,rightMarker]{
            marker.backgroundColor = markerColor
        }
        
        if isSetuped {
            return
        }
        isSetuped = true
        
        layer.cornerRadius = frame.size.width/2
        
        for marker in [topMarker,bottomMarker,leftMarker,rightMarker]{
           addSubview(marker)
        }
        addSubview(hourLine)
    }

    
    func updateHours(){
        let angle = CGFloat.pi * 2 * (hours/12)
        hourLine.transform = CGAffineTransform(rotationAngle: angle)
    }
}
