//
//  ViewController.swift
//  Standart UI
//
//  Created by Vladimir Mustafin on 16.08.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController {

    @IBOutlet weak var setImageView: UIImageView!
    @IBOutlet weak var generateUIButton: UIButton!
    @IBOutlet weak var imageUISlider: UISlider!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var imageStepper: UIStepper!
    
    
    let imageSetNames = ["first","second","third","forth",
                         "fifth","six","eight","nine"]
    var imageArray:[UIImage]? = []
    let animationDuration:Float80 = 8.0
    var startOfAnimation: DispatchTime?
    var currentImageIndex = 0
    var notFirstTime = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in imageSetNames {
            imageArray?.append(UIImage(imageLiteralResourceName: item))
        }
        self.setImageView.animationImages = imageArray
        self.setImageView.animationDuration = TimeInterval(animationDuration)
        imageUISlider.minimumValue = 0
        imageUISlider.maximumValue = Float(imageArray?.count ?? 0) - 1
        imageStepper.maximumValue = Double((imageArray?.count ?? 0) - 1)
        stopButton.isHidden = true
    }

    @IBAction func startImageAnimation() {
        self.setImageView.startAnimating()
        self.startOfAnimation = DispatchTime.now()
        stopButton.isHidden = false
        startButton.isHidden = true
        imageUISlider.setValue(0, animated: true)
        imageStepper.value = Double(0)
    }
    
    
    @IBAction func stopImageAnimation() {
        if self.setImageView.isAnimating {
            let end = DispatchTime.now()
            self.setImageView.stopAnimating()
            let interval = end.uptimeNanoseconds - (startOfAnimation?.uptimeNanoseconds ?? 0)
            let timeInterval = Float80(interval) / 1_000_000_000
            self.setImageView.image = imageArray?[getImageIndex(timeInterval: timeInterval)]
            stopButton.isHidden = true
            startButton.isHidden = false
            imageUISlider.setValue(Float(currentImageIndex), animated: true)
            imageStepper.value = Double(currentImageIndex)
        }
   }
    
    @IBAction func changeImagesSlider(_ sender: UISlider) {
        guard !self.setImageView.isAnimating else {
            return
        }
        guard sender == imageUISlider else {
            return
        }
        currentImageIndex = Int(imageUISlider.value)
        self.setImageView.image = imageArray?[Int(imageUISlider.value)]
        imageStepper.value = Double(currentImageIndex)
    }
    
    
    @IBAction func changeImageStepper(_ sender: UIStepper) {
        guard !self.setImageView.isAnimating else {
            return
        }
        guard sender == imageStepper else {
            return
        }
        currentImageIndex = Int(imageStepper.value)
        self.setImageView.image = imageArray?[Int(imageStepper.value)]
        imageUISlider.setValue(Float(currentImageIndex), animated: true)
    }
    
    
    
    private func getImageIndex(timeInterval:Float80) -> Int{
        let amount = (Float80(imageArray?.count ?? 0) / Float80(animationDuration)) * timeInterval
        currentImageIndex = Int(amount) % (imageArray?.count ?? 0)
        guard notFirstTime else {
            if(currentImageIndex != 0){
                currentImageIndex -= 1
            }else{
                currentImageIndex = (imageArray?.count ?? 0) - 1
            }
            notFirstTime = true
            return currentImageIndex
        }
        return currentImageIndex
    }
}
