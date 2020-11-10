//
//  CustomSegmentControl.swift
//  UIElements
//
//  Created by Vladimir Mustafin on 09.11.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentControl: UIView {
    
    var isSetuped = false
    
    var isHorizontal = true
    
    @IBInspectable var segmentAmount:Int = 2 {
        didSet{
            if segmentAmount >= 10{
                segmentAmount = 9
            }
            updateLayout()
        }
    }
    
    @IBInspectable var buttonName:String = "" {
        didSet{
            updateButtonsName()
            layoutIfNeeded()
        }
    }
    
   var buttonIndex:Int = 0{
        didSet{
            if(buttonIndex >= buttonArray.count){
                buttonIndex = buttonArray.count - 1
            }
            
        }
    }
    
    var buttonArray: [UIButton] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateButtonArray()
        
        if isSetuped{ return }
        isSetuped = true
        
    }
    
    private func updateLayout(){
        let (width,height) = getElementSize()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        for (index,button) in buttonArray.enumerated(){
            if isHorizontal{
                button.frame = CGRect(x: CGFloat(index)*width , y: 0, width: width, height: height)
            }else{
                button.frame = CGRect(x: 0 , y: CGFloat(index)*height, width: width, height: height)
            }
            if(!isSetuped){
                button.setTitle(String(index), for: .normal)
            }
            button.titleLabel?.textColor = .white
            button.backgroundColor = .lightGray
            addSubview(button)
            button.addGestureRecognizer(gesture)
        }
        
    }
    
    private func updateButtonArray(){
        if segmentAmount > buttonArray.count{
            
            while segmentAmount != buttonArray.count{
                buttonArray.append(UIButton())
            }
            
        }else{
            
            while segmentAmount != buttonArray.count {
                buttonArray[buttonArray.count - 1].removeFromSuperview()
                buttonArray.remove(at: buttonArray.count - 1)
            }
            
        }
        updateLayout()
    }
    
    private func getElementSize() -> (CGFloat,CGFloat){
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
    
    private func updateButtonsName() {
        for item in buttonArray {
            item.titleLabel?.text = buttonName
        }
    }
    

    @objc func someAction(_ sender:UITapGestureRecognizer){
        print("view was clicked")
    }
    
}
