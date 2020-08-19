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
    

    let imageSetNames = ["first","second","third","forth",
                         "fifth","six","eight","nine"]
    
    var currentImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextImage(_ sender: UIButton) {
        currentImageIndex += 1
        if(currentImageIndex >= 8){
            currentImageIndex = 0
        }
        setImageView.image = UIImage(imageLiteralResourceName: imageSetNames[currentImageIndex])
    }
    
    
    @IBAction func backImage(_ sender: UIButton) {
        currentImageIndex -= 1
        if(currentImageIndex <= 0){
            currentImageIndex = 7
        }
        setImageView.image = UIImage(imageLiteralResourceName: imageSetNames[currentImageIndex])
    }
}

