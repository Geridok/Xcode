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
    
    let animatableView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let animationIndex = [0,1,2,3,4,5]
    var rightAnchor: NSLayoutConstraint?
    var leftAnchor: NSLayoutConstraint?
    var topAnchor: NSLayoutConstraint?
    var widthAnchor: NSLayoutConstraint?
    var heightAnchor: NSLayoutConstraint?
    
    private let kRotationAnimationKey = "rotationanimationkey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(animatableView)
        topAnchor = animatableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        topAnchor?.isActive = true
        leftAnchor = animatableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        leftAnchor?.isActive = true
        widthAnchor = animatableView.widthAnchor.constraint(equalToConstant: 100)
        widthAnchor?.isActive = true
        heightAnchor = animatableView.heightAnchor.constraint(equalToConstant: 100)
        heightAnchor?.isActive = true
        rightAnchor = animatableView.rightAnchor.constraint(equalTo: view.rightAnchor)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        changeViewBackgroundColor(color: .yellow)
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
            changeViewBackgroundColor(color: .yellow)
        case 1:
            moveViewToRightPoint()
        case 2:
            ViewToCircle(duration: 3.0)
        case 3:
            rotateView(duration: 3.0)
        case 4:
            viewDisappearance()
        case 5:
            viewGrow()
        default:
            return
        }
    }
    
    private func changeViewBackgroundColor(color: UIColor,duration: CGFloat = 0.5){
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: .autoreverse, animations: {
            self.animatableView.backgroundColor = color
        }) { (isCompleted) in
            if(isCompleted){
                self.animatableView.backgroundColor = .red
            }
        }
    }
    
    private func moveViewToRightPoint(duration: CGFloat = 1.0){
        leftAnchor?.isActive = false
        rightAnchor?.isActive = true
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.autoreverse,.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.rightAnchor?.isActive = false
            self.leftAnchor?.isActive = true
        })
    }
    private func ViewToCircle(duration: CGFloat = 1.0){
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = NSNumber(value: 0)
        animation.toValue = NSNumber(value: Float(animatableView.frame.width/2))
        animation.duration = TimeInterval(duration)
        animation.autoreverses = true
        animatableView.layer.add(animation,forKey: "cornerRadius")
        
    }
    
    private func rotateView(duration: CGFloat = 1.0,angle: Double = Double.pi) {
            let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotation.toValue = NSNumber(value: angle)
            rotation.duration = TimeInterval(duration)
            animatableView.layer.add(rotation, forKey: "transform.rotation")
        }
    private func viewDisappearance(duration: CGFloat = 1.0){
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .autoreverse, animations: {
            self.animatableView.alpha = 0
        }, completion: { _ in
            self.animatableView.alpha = 1.0
        })
    }
    private func viewGrow(duration: CGFloat = 2.0){
        leftAnchor?.isActive = false
        rightAnchor?.isActive = false
        topAnchor?.isActive = false
        let centerXAnchor = animatableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        centerXAnchor.isActive = true
        let centerYAnchor = animatableView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        centerYAnchor.isActive = true
        //widthAnchor?.isActive = false
        //heightAnchor?.isActive = false
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .autoreverse, animations: {
            self.animatableView.transform = CGAffineTransform(scaleX: 2,y: 2)
            self.view.layoutIfNeeded()
        }, completion: { _ in
            centerXAnchor.isActive = false
            centerYAnchor.isActive = false
            self.leftAnchor?.isActive = true
            self.topAnchor?.isActive  = true
            self.animatableView.transform = CGAffineTransform(scaleX: 1,y: 1)
        })
    }

      private func infinityViewRotate(duration: Double = 1) {
            if animatableView.layer.animation(forKey: kRotationAnimationKey) == nil {
                let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

                rotationAnimation.fromValue = 0.0
                rotationAnimation.toValue = Float.pi * 2.0
                rotationAnimation.duration = duration
                rotationAnimation.repeatCount = Float.infinity

                animatableView.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
            }
        }

       private func stopInfinityRotating() {
            if animatableView.layer.animation(forKey: kRotationAnimationKey) != nil {
                animatableView.layer.removeAnimation(forKey: kRotationAnimationKey)
            }
        }
    
    @IBAction func startOrStopRotating(_ sender: UIButton) {
        if(sender.titleLabel!.text == "Start Rotation"){
            sender.setTitle("Stop Rotation", for: .normal)
            infinityViewRotate()
        }else{
            sender.setTitle("Start Rotation", for: .normal)
            stopInfinityRotating()
        }
        
    }
}

