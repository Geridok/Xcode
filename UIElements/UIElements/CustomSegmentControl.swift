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
            //updateButtons()
           // layoutIfNeeded()
        }
    }
    
   @IBInspectable var buttonIndex:Int = 3{
        didSet{
            if(buttonIndex >= buttonArray.count){
                buttonIndex = buttonArray.count - 1
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
        self.backgroundColor = .lightGray
        highlightView.layer.cornerRadius = 10
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
            button.titleLabel?.textColor = .white
            addSubview(button)
            button.addTarget(self, action: #selector(self.someAction(_:)), for: .touchUpInside)
            self.bringSubviewToFront(button.titleLabel!)
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
    
    private func updateButtons() {
            buttonArray[buttonIndex].titleLabel?.text = buttonName
            buttonArray[buttonIndex].setTitle(buttonName, for: .normal)
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
