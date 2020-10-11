//
//  ViewController.swift
//  Tables&Collections
//
//  Created by Vladimir Mustafin on 23.09.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {


    var markIsFilled = false
    let clothesDescription:[String] = [ "MOCK NECK TOP","ALLOVER PRINT HOODIE","CROPPED LOGO BACK HOODIE","POINTELLE CARDIGAN", "FLAG LOGO SWEATER","SCOOP-NECK BODYSUIT","STRIPE OXFORD SHIRT88","ORGANIC COTTON DRAWSTRING PANT" ]
    
    let clothesImages = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg"].map{ UIImage(imageLiteralResourceName: $0) }
    
    let clothesOldPrice = [120,100,98,110,76,88,94,99,76]
    let clothesDiscountPercent = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ShopViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothesDescription.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCollectionViewCell
        cell.productUIImageView.image = clothesImages[indexPath.row]
        let attrString = NSAttributedString(string: String(clothesOldPrice[indexPath.row]) + "$", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        cell.oldPriceUILabel.attributedText = attrString
        cell.newPriceUILabel.text = String((clothesOldPrice[indexPath.row]*clothesDiscountPercent)/100) + "$"
        cell.DescriptionUILabel.text = clothesDescription[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //return CGSize(width: UIScreen.main.bounds.width/2, height:  UIScreen.main.bounds.height/2)
        var numberOfCellInRow : Int = 0
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
               numberOfCellInRow = 2
        case .pad:
               numberOfCellInRow = 3
        case .tv:
            break
        case .carPlay:
            break
        case .unspecified:
            break
        @unknown default:
            break
        }
        var collectionCellWidth : CGFloat = (self.view.frame.size.width/CGFloat(numberOfCellInRow)) - 15
        return CGSize(width: collectionCellWidth , height: collectionCellWidth*2)
    }
    
}
