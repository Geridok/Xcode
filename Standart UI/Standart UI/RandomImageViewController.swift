//
//  RandomImageViewController.swift
//  Standart UI
//
//  Created by Vladimir Mustafin on 19.08.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class RandomImageViewController: UIViewController {

    let imageSetNames = ["first","second","third","forth",
                            "fifth","six","eight","nine"]
    var UIImageViewSet: [UIImageView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let width:UInt = 200
        let height:UInt = 200
        for i in 0...1 {
            for j in 1...2 {
                UIImageViewSet.append(createImageView(width: width, height: height, offsetX: UInt(220*i), offSetY: UInt(j*200)))
            }
        }
        for i in 0...3 {
            self.view.addSubview(UIImageViewSet[i])
        }
        
    }
    
    private func createImageView(width: UInt, height: UInt, offsetX: UInt, offSetY: UInt)->UIImageView{
        let imageView = UIImageView()
        imageView.frame = CGRect(x: CGFloat(offsetX), y: CGFloat(offSetY), width: CGFloat(width), height: CGFloat(height))
        imageView.image = UIImage(imageLiteralResourceName:imageSetNames[Int.random(in: 0..<8)])
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
