//
//  BurgerCustomCollectiveViewController.swift
//  Tables&Collections
//
//  Created by Vladimir Mustafin on 02.11.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class BurgerCustomCollectiveViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var informationScrollView: UIScrollView!
    @IBOutlet weak var burgersCollectionView: UICollectionView!
    @IBOutlet weak var informationView: UIView!
    
    let burgerImages = ["_1.jpg","_2.jpg","_3.jpg","_4.jpg","_5.jpg","_6.jpg"].map{ UIImage(imageLiteralResourceName: $0)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = "Какое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеописаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеописаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеописаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеописаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описаниеКакое-то описание"
        informationScrollView.clipsToBounds = true
        informationScrollView.layer.cornerRadius = 15
    }
    
    

}

extension BurgerCustomCollectiveViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return burgerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! BurgerImageCollectionViewCell
        cell.burgerImageView.image = burgerImages[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.size.width,height: collectionView.frame.size.height)
        
    }
    
}
