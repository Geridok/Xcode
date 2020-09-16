//
//  ViewController.swift
//  CustomViewController
//
//  Created by Vladimir Mustafin on 14.09.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
    @IBOutlet var buttonArray:[UIButton]!
    
    var UIImageArrayFill:[UIImage]? = ["1.circle.fill","2.circle.fill","3.circle.fill"].map { UIImage(systemName: $0) } as? [UIImage]
    
    var UIImageArray:[UIImage]? = ["1.circle","2.circle","3.circle"].map { UIImage(systemName: $0) } as? [UIImage]
    
    var viewControllerArray:[UIViewController] = []
    
    @IBOutlet weak var safeAreaForControllers: UIView!
    
    var rectForBound:CGRect?
    var rectForTopView:CGRect?
    var rectForBottomView:CGRect?
    
    var isFilling:[Bool] = []
    var lastShowed:[Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let arr = UIImageArrayFill{
            for _ in arr.enumerated() {
                isFilling.append(false)
                lastShowed.append(false)
            }
        }
        let size = safeAreaForControllers.bounds.size
        rectForTopView = CGRect(x: safeAreaForControllers.frame.origin.x, y: safeAreaForControllers.frame.origin.y, width: size.width, height: size.height/2)
        rectForBottomView = CGRect(x: safeAreaForControllers.frame.origin.x, y: safeAreaForControllers.frame.origin.y + size.height/2, width: size.width, height: size.height/2)
        rectForBound = CGRect(x: 0, y: 0, width: size.width, height: size.height/2)
        viewControllerArray.append(createViewController(backgroundColor: .blue, bound: rectForBound!))
        viewControllerArray.append(createViewController(backgroundColor: .red, bound: rectForBound!))
        viewControllerArray.append(createViewController(backgroundColor: .yellow, bound: rectForBound!))
        for item in viewControllerArray {
            self.view.addSubview(item.view)
            item.view.isHidden = true
        }
    }

    @IBAction func viewChoice(_ sender: UIButton) {
       
        if let pressedButton = buttonArray.firstIndex(of: sender){
            
            //Here you should hide the stub
            
            if isFilling[pressedButton] {
                sender.setImage(UIImageArray?[pressedButton], for: .normal)
                isFilling[pressedButton] = false
                viewControllerArray[pressedButton].view.isHidden = true
                lastShowed[pressedButton] = false
                if let fillButtonIndex = isFilling.firstIndex(of: true){
                    lastShowed[fillButtonIndex] = true
                }else{
                    //You can specify a stub here
                }
            }else{
                showController(pressedButton: pressedButton)
                sender.setImage(UIImageArrayFill?[pressedButton], for: .normal)
                isFilling[pressedButton] = true
            }
            }
        }
        
    private func createViewController( backgroundColor:UIColor, bound:CGRect)->UIViewController{
        let newViewController = UIViewController()
        newViewController.view.backgroundColor = backgroundColor
        newViewController.view.bounds = bound
        return newViewController
    }
    
    private func showController(pressedButton: Array<Any>.Index){
        var count = 0
        for item in isFilling {
            if item == true {
                count += 1
            }
        }
            if let lastShowedIndex = lastShowed.firstIndex(of: true){
                if(count == 2){
                    if viewControllerArray[lastShowedIndex].view.frame == rectForTopView {
                        viewControllerArray[pressedButton].view.frame = rectForTopView!
                    }else{
                        viewControllerArray[pressedButton].view.frame = rectForBottomView!
                    }
                    viewChoice(buttonArray[lastShowedIndex])
                    lastShowed[pressedButton] = true
                    viewControllerArray[pressedButton].view.isHidden = false
                }else{
                        if viewControllerArray[lastShowedIndex].view.frame == rectForTopView {
                            viewControllerArray[pressedButton].view.frame = rectForBottomView!
                        }else{
                            viewControllerArray[pressedButton].view.frame = rectForTopView!
                        }
                    lastShowed[lastShowedIndex] = false
                    lastShowed[pressedButton] = true
                    viewControllerArray[pressedButton].view.isHidden = false
                }
            }else{
                lastShowed[pressedButton] = true
                viewControllerArray[pressedButton].view.frame = rectForTopView!
                viewControllerArray[pressedButton].view.isHidden = false
        }
        
    }
    
}

