//
//  ViewController.swift
//  StandartAnimation
//
//  Created by Vladimir Mustafin on 05.04.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var animationIndexlabel: UILabel!
    
    @IBOutlet weak var animatableView: UIView!
    
    let animationIndex = [0,1,2,3,4,5,6,7]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        changeBackgroundColor(color: .yellow)
    }
    
    @IBAction func changeAnimation(_ sender: UIButton) {
        var currentIndex = 0
        if (sender == nextButton) {
            currentIndex = (Int(animationIndexlabel.text ?? "0") ?? 0 ) + 1
            if(currentIndex > animationIndex[animationIndex.endIndex - 1]){
                currentIndex = animationIndex[animationIndex[0]]
            }
        }else{
            currentIndex = (Int(animationIndexlabel.text ?? "0") ?? 0) - 1
            if(currentIndex < animationIndex[0]){
                currentIndex = animationIndex[animationIndex.endIndex - 1]
            }
        }
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = 0.4
        animationIndexlabel.layer.add(animation, forKey: CATransitionType.fade.rawValue)
        
        animationIndexlabel.text = String(currentIndex)
        
        switch currentIndex {
        case 0:
            changeBackgroundColor(color: .yellow)
        case 1:
            moveToRightPoint()
        case 2:
            changeBackgroundColor(color: .yellow)
        case 3:
            changeBackgroundColor(color: .yellow)
        case 4:
            changeBackgroundColor(color: .yellow)
        case 5:
            changeBackgroundColor(color: .yellow)
        case 6:
            changeBackgroundColor(color: .yellow)
        case 7:
            changeBackgroundColor(color: .yellow)
        default:
            return
        }
    }
    
    private func changeBackgroundColor(color: UIColor,duration: CGFloat = 0.5){
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: .autoreverse, animations: {
            self.animatableView.backgroundColor = color
        }) { (isCompleted) in
            if(isCompleted){
                self.animatableView.backgroundColor = .red
            }
        }
    }
    
    private func moveToRightPoint(duration: CGFloat = 1.5){
        //self.animatableView.frame.origin.y = 44
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.5, animations: {
            self.animatableView.frame.origin.y = 400
        }) { (isCompleted) in
            if(isCompleted){
                self.animatableView.frame.origin.y = 44
            }
        }
    }
    
}

