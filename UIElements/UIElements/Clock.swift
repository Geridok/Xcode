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
    @IBInspectable private var hourLineOffset:CGFloat = 5 {
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
    @IBInspectable private var minLineSize:CGFloat = 20 {
        didSet{
            layoutIfNeeded()
        }
    }
    @IBInspectable private var minLineOffset:CGFloat = 5 {
        didSet{
            layoutIfNeeded()
        }
    }
    @IBInspectable private var minLineColor: UIColor = .black {
        didSet{
            minLine.backgroundColor = minLineColor
        }
    }
    
    private let secLine = UIView()
    @IBInspectable private var secLineSize:CGFloat = 20 {
        didSet{
            layoutIfNeeded()
        }
    }
    @IBInspectable private var secLineOffset:CGFloat = 5 {
        didSet{
            layoutIfNeeded()
        }
    }
    @IBInspectable private var secLineColor: UIColor = .black {
        didSet{
            secLine.backgroundColor = secLineColor
        }
    }
    
    override init(frame: CGRect) {
       super.init(frame: CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 100, height: 100)))
        
        print("Hi frame")
        
        let w = frame.size.width
        let h = frame.size.height
        
        topMarker.frame = CGRect(x: w/2 - markerSize / 2, y: 0, width: markerSize, height: markerLenght)
        bottomMarker.frame = CGRect(x: w/2 - markerSize/2, y: h - markerLenght, width: markerSize, height: markerLenght)
        leftMarker.frame = CGRect(x: 0, y: h/2 - markerSize/2, width: markerLenght, height: markerSize)
        rightMarker.frame = CGRect(x: w - markerLenght, y: h/2 - markerSize/2, width: markerLenght, height: markerSize)
        
        
        hourLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        minLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        secLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        for item in [topMarker,bottomMarker,leftMarker,rightMarker,hourLine,minLine,secLine]{
            self.addSubview(item)
        }
        
        layer.cornerRadius = frame.size.width/2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //print("Hi NSCoder")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = frame.size.width
        let h = frame.size.height
        
        hourLine.frame = CGRect(x: w/2 - hourLineSize/2, y: hourLineOffset, width: hourLineSize, height: h/2 - hourLineOffset)
        minLine.frame = CGRect(x: w/2 - minLineSize/2, y: minLineOffset, width: minLineSize, height: h/2 - minLineOffset)
        secLine.frame = CGRect(x: w/2 - secLineSize/2, y: secLineOffset, width: secLineSize, height: h/2 - minLineOffset)
        
        for item in [topMarker,bottomMarker,leftMarker,rightMarker]{
            item.backgroundColor = markerColor
        }

    }

}
