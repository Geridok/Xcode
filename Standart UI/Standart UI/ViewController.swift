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
    @IBOutlet weak var imageProgressiveView: UIProgressView!
    
    
    let imageSetNames = ["first","second","third","forth",
                         "fifth","six","eight","nine"]
    var imageArray:[UIImage]  = []
    let timeForOneImage:TimeInterval = 0.5
    var startOfAnimation: DispatchTime?
    var animating = false
    var timer: Timer?
    var progress:Progress?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in imageSetNames {
            imageArray.append(UIImage(imageLiteralResourceName: item))
        }
        imageUISlider.minimumValue = 0
        imageUISlider.maximumValue = Float(imageArray.count) - 1
        imageStepper.maximumValue = Double((imageArray.count) - 1)
        stopButton.isHidden = true
        progress = Progress(totalUnitCount: Int64(imageArray.count) - 1)

    }

    @IBAction func startImageAnimation() {
        if let loc_progres = self.progress{
        timer = Timer.scheduledTimer(withTimeInterval: timeForOneImage, repeats: true){ timer in
            loc_progres.completedUnitCount += 1
            if(!((loc_progres.completedUnitCount) < Int64(self.imageArray.count))){
                loc_progres.completedUnitCount = 0
            }
            self.setImageView.image = self.imageArray[Int(loc_progres.completedUnitCount)]
            self.updateUIElements()
            self.animating = true
            
        }
        stopButton.isHidden = false
        startButton.isHidden = true
        }
    }
    
    
    @IBAction func stopImageAnimation() {
        if self.animating {
            timer?.invalidate()
            self.animating = false
            stopButton.isHidden = true
            startButton.isHidden = false
            
        }
   }
    
    @IBAction func changeImagesSlider(_ sender: UISlider) {
        guard !self.animating else {
            return
        }
        guard sender == imageUISlider else {
            return
        }
        if let locProgress = progress {
            locProgress.completedUnitCount = Int64(imageUISlider.value)
            self.setImageView.image = imageArray[Int(imageUISlider.value)]
            imageStepper.value = Double(locProgress.completedUnitCount)
            imageProgressiveView.setProgress(Float(locProgress.fractionCompleted), animated: true)
        }
    }
    
    
    @IBAction func changeImageStepper(_ sender: UIStepper) {
        guard !self.animating else {
            return
        }
        guard sender == imageStepper else {
            return
        }
        if let locProgress = progress {
            locProgress.completedUnitCount = Int64(imageStepper.value)
            self.setImageView.image = imageArray[Int(imageStepper.value)]
            updateUIElements()
        }
    }
    private func updateUIElements(){
        if let locProgress = progress {
            imageUISlider.setValue(Float(locProgress.completedUnitCount), animated: true)
            imageStepper.value = Double(locProgress.completedUnitCount)
            imageProgressiveView.setProgress(Float(locProgress.fractionCompleted), animated: true)
        }
    }
    
}
