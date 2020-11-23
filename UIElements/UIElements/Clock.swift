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

    
    var markerSize:CGFloat = 3
    var markerLenght:CGFloat = 12
    var markerColor = UIColor.blue
    
    private let topMarker = UIView()
    private let bottomMarker = UIView()
    private let leftMarker = UIView()
    private let rightMarker = UIView()
    
    private let hourLine = UIView()
    @IBInspectable private var hourLineSize:CGFloat = 20 {
        didSet{
            layoutIfNeeded()
        }
    }
    @IBInspectable private var hourLineOffset:CGFloat = 0 {
        didSet{
            layoutIfNeeded()
        }
    }
    @IBInspectable private var hourLineColor: UIColor = .black {
        didSet{
            hourLine.backgroundColor = hourLineColor
        }
    }
    
    
    private let minLine = UIView()
    @IBInspectable private var minLineSize:CGFloat = 10 {
        didSet{
            layoutIfNeeded()
        }
    }
    @IBInspectable private var minLineOffset:CGFloat = 0 {
        didSet{
            layoutIfNeeded()
        }
    }
    @IBInspectable private var minLineColor: UIColor = .yellow {
        didSet{
            minLine.backgroundColor = minLineColor
        }
    }
    

    
    private let secLine = UIView()
    @IBInspectable private var secLineSize:CGFloat = 5 {
        didSet{
            layoutIfNeeded()
        }
    }
    @IBInspectable private var secLineOffset:CGFloat = 0 {
        didSet{
            layoutIfNeeded()
        }
    }
    @IBInspectable private var secLineColor: UIColor = .green {
        didSet{
            secLine.backgroundColor = secLineColor
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.cornerRadius = frame.size.width/2
        
        let w = frame.size.width
        let h = frame.size.height
        
        topMarker.frame = CGRect(x: w/2 - markerSize / 2, y: 0, width: markerSize, height: markerLenght)
        bottomMarker.frame = CGRect(x: w/2 - markerSize/2, y: h - markerLenght, width: markerSize, height: markerLenght)
        leftMarker.frame = CGRect(x: 0, y: h/2 - markerSize/2, width: markerLenght, height: markerSize)
        rightMarker.frame = CGRect(x: w - markerLenght, y: h/2 - markerSize/2, width: markerLenght, height: markerSize)
        
        
        
        hourLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        minLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        secLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        for item in [topMarker,bottomMarker,leftMarker,rightMarker]{
            item.backgroundColor = markerColor
        }
        hourLine.backgroundColor = hourLineColor
        minLine.backgroundColor = minLineColor
        secLine.backgroundColor = secLineColor
        
        for item in [topMarker,bottomMarker,leftMarker,rightMarker,hourLine,minLine,secLine]{
            self.addSubview(item)
        }
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = frame.size.width
        let h = frame.size.height
        
        hourLine.frame = CGRect(x: w/2 - hourLineSize/2, y: hourLineOffset, width: hourLineSize, height: h/2 - hourLineOffset)
        minLine.frame = CGRect(x: w/2 - minLineSize/2, y: minLineOffset, width: minLineSize, height: h/2 - minLineOffset)
        secLine.frame = CGRect(x: w/2 - secLineSize/2, y: secLineOffset, width: secLineSize, height: h/2 - minLineOffset)
        
    }


}
