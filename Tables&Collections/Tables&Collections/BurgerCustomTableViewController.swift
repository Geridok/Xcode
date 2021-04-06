//
//  BurgerViewController.swift
//  Tables&Collections
//
//  Created by Vladimir Mustafin on 22.10.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class BurgerCustomTableViewController: UIViewController {
    @IBOutlet weak var burgersScrollView: UIScrollView!
    @IBOutlet weak var burgersSafeArea: UIView!
    @IBOutlet weak var informationSafeArea: UIView!
    @IBOutlet weak var informationScrollView: UIScrollView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let burgerImages = ["_1.jpg","_2.jpg","_3.jpg","_4.jpg","_5.jpg","_6.jpg"].map{ UIImage(imageLiteralResourceName: $0)}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //generateBurgersImages()
        descriptionLabel.text = "Какое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описание"
        informationScrollView.clipsToBounds = true
        informationScrollView.layer.cornerRadius = 15
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        generateBurgersImages()
    }

    private func generateBurgersImages(){
        for (index,image) in burgerImages.enumerated() {
            let x = CGFloat(index) * burgersSafeArea.frame.size.width
            let cell = UIImageView(frame: CGRect(x: x, y: 0, width: burgersSafeArea.frame.size.width, height: burgersSafeArea.frame.size.height))
            cell.image = image
            cell.contentMode = .scaleAspectFill
            burgersScrollView.addSubview(cell)
        }
        burgersScrollView.contentSize = CGSize(width: CGFloat(burgerImages.count) * burgersSafeArea.frame.size.width, height: burgersSafeArea.frame.size.height)
    }
}

