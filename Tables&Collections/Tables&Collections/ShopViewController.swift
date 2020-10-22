//
//  ViewController.swift
//  Tables&Collections
//
//  Created by Vladimir Mustafin on 23.09.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit


struct Product {
    let name:String
    let image:UIImage
    let price:Double
}

struct ProductsFabric {
    static func getAllProducts()->[Product]{
        return [
            Product(name: "MOCK NECK TOP", image: UIImage(imageLiteralResourceName: "1.jpg"), price: 120),
            Product(name: "ALLOVER PRINT HOODIE", image: UIImage(imageLiteralResourceName: "2.jpg"), price: 100),
            Product(name: "CROPPED LOGO BACK HOODIE", image: UIImage(imageLiteralResourceName: "3.jpg"), price: 98),
            Product(name: "POINTELLE CARDIGAN", image: UIImage(imageLiteralResourceName: "4.jpg"), price: 110),
            Product(name: "FLAG LOGO SWEATER", image: UIImage(imageLiteralResourceName: "5.jpg"), price: 76),
            Product(name: "SCOOP-NECK BODYSUIT", image: UIImage(imageLiteralResourceName: "6.jpg"), price: 88),
            Product(name: "STRIPE OXFORD SHIRT88", image: UIImage(imageLiteralResourceName: "7.jpg"), price: 94),
            Product(name: "ORGANIC COTTON DRAWSTRING PANT", image: UIImage(imageLiteralResourceName: "8.jpg"), price: 99),
        
        ]
    }
}

class ShopViewController: UIViewController {


    var markIsFilled = false
    let products = ProductsFabric.getAllProducts()
    
    let clothesDiscountPercent:Double = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ShopViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCollectionViewCell
        cell.productUIImageView.image = products[indexPath.row].image
        let attrString = NSAttributedString(string: String(products[indexPath.row].price) + "$", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        cell.oldPriceUILabel.attributedText = attrString
        cell.newPriceUILabel.text = String((products[indexPath.row].price * clothesDiscountPercent)/100) + "$"
        cell.DescriptionUILabel.text = products[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
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
        let collectionCellWidth : CGFloat = (self.view.frame.size.width/CGFloat(numberOfCellInRow)) - 15
        return CGSize(width: collectionCellWidth , height: collectionCellWidth*2)
    }
    
}
