//
//  CustomSegmentControl.swift
//  UIElements
//
//  Created by Vladimir Mustafin on 09.11.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

protocol WhichPressedCustomSegmentControlDelegate: NSObjectProtocol {
    func whichPressed(_ segmentControl:CustomSegmentControl,_ sender:UIButton)
}

@IBDesignable
class CustomSegmentControl: UIView {
    
    var isSetuped = false
    var isHorizontal = true
    weak var delegate:WhichPressedCustomSegmentControlDelegate?
    
    @IBInspectable var mainColor:UIColor = .lightGray {
        didSet{
            self.backgroundColor = mainColor
        }
    }
    
    @IBInspectable var segmentAmount:Int = 1 {
        didSet{
            if segmentAmount >= 5{
                segmentAmount = 5
            }else if(segmentAmount < 2){
                segmentAmount = 2 
            }
            updateLayout()
        }
    }
    @IBInspectable var buttonName_1:String = "" {
        didSet{
            buttonArray[0].setTitle(buttonName_1, for: .normal)
        }
    }
    @IBInspectable var buttonName_2:String = "" {
        didSet{
            buttonArray[1].setTitle(buttonName_1, for: .normal)
        }
    }
    @IBInspectable var buttonName_3:String = "" {
        didSet{
            if buttonArray.count >= 3 {
                buttonArray[3].setTitle(buttonName_1, for: .normal)
            }
        }
    }
    @IBInspectable var buttonName_4:String = "" {
        didSet{
            if buttonArray.count >= 4 {
                buttonArray[4].setTitle(buttonName_1, for: .normal)
            }
        }
    }
    @IBInspectable var buttonName_5:String = "" {
        didSet{
            if buttonArray.count >= 5 {
                buttonArray[5].setTitle(buttonName_1, for: .normal)
            }
        }
    }
    
    
    var buttonArray: [UIButton] = []
    
    var highlightView = UIView()
    
    @IBInspectable var highlightColor:UIColor = .blue{
        didSet{
            highlightView.backgroundColor = highlightColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        if isSetuped{ return }
        isSetuped = true
        updateButtonArray()
        addSubview(highlightView)
        self.backgroundColor = mainColor
        highlightView.layer.cornerRadius = 10
        self.sendSubviewToBack(highlightView)
    }
    
    private func updateLayout(){
        let (width,height) = getElementSize()
        
        highlightView.frame = CGRect(x: 0, y: 0, width: width , height: height)
        highlightView.backgroundColor = highlightColor
        
        
        for (index,button) in buttonArray.enumerated(){
            if isHorizontal{
                button.frame = CGRect(x: CGFloat(index)*width , y: 0, width: width, height: height)
            }else{
                button.frame = CGRect(x: 0 , y: CGFloat(index)*height, width: width, height: height)
            }
            if(!isSetuped){
                button.setTitle(String(index), for: .normal)
            }
            button.titleLabel?.textColor = .black
            addSubview(button)
            button.addTarget(self, action: #selector(self.someAction(_:)), for: .touchUpInside)
            self.bringSubviewToFront(button.titleLabel!)
        }
        
    }
    
    private func updateButtonArray(){
        if segmentAmount > buttonArray.count{
            while segmentAmount != buttonArray.count{
                let but = UIButton()
                buttonArray.append(but)
                but.setTitle(String(buttonArray.count), for: .normal)
            }
            
        }else{
            while segmentAmount != buttonArray.count {
                buttonArray[buttonArray.count - 1].removeFromSuperview()
                buttonArray.remove(at: buttonArray.count - 1)
            }
            
        }
        updateLayout()
    }
    
    private func getElementSize() -> (width: CGFloat,height: CGFloat){
        if (frame.size.width >= frame.size.height){
            isHorizontal = true
            let w = frame.size.width / CGFloat(segmentAmount)
            let h = frame.size.height
            return (w,h)
        }else{
            isHorizontal = false
            let w = frame.size.width
            let h = frame.size.height / CGFloat(segmentAmount)
            return (w,h)
        }
    }

    @IBAction func someAction(_ sender: UIButton){
        
        let (width,height) = getElementSize()
        if let index = buttonArray.firstIndex(of: sender){
            
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
           var HighlightFrame = self.highlightView.frame
            if self.isHorizontal {
                HighlightFrame.origin.x  = width*CGFloat(index)
            }else{
                HighlightFrame.origin.y = height*CGFloat(index)
            }
            self.highlightView.frame = HighlightFrame
         })
            
            delegate?.whichPressed(self, sender)
    }
        
    }
}
