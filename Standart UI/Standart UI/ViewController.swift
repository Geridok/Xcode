//
//  ViewController.swift
//  Standart UI
//
//  Created by Vladimir Mustafin on 16.08.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var setImageView: UIImageView!
    @IBOutlet weak var generateUIButton: UIButton!
    

    let imageSetNames = ["first","second","third","forth",
                         "fifth","six","eight","nine"]
    var UIImageArray:[UIImage] = []
    var currentImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateUIButton.layer.cornerRadius = 55
        for item in imageSetNames {
            UIImageArray.append(UIImage(imageLiteralResourceName: item))
        }
    }

    @IBAction func nextImage() {
        currentImageIndex += 1
        if(currentImageIndex >= 8){
            currentImageIndex = 0
        }
        setImageView.image = UIImageArray[currentImageIndex]
    }
    
    
    @IBAction func backImage() {
        currentImageIndex -= 1
        if(currentImageIndex <= 0){
            currentImageIndex = 7
        }
        setImageView.image = UIImageArray[currentImageIndex]
    }
}

