//
//  ViewController.swift
//  Constraints
//
//  Created by Vladimir Mustafin on 27.08.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView?
    
    @IBOutlet weak var fromLabel: UILabel?
    @IBOutlet weak var arrowLabel: UILabel?
    @IBOutlet weak var toLabel: UILabel?
    @IBOutlet weak var bottomLabel: UILabel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureEnd))
            self.view.addGestureRecognizer(tapGesture)
    
        }
        
    @objc func tapGestureEnd(){
            view.endEditing(true)
        }

    var isFromBig = false
    var isToBig = false
    
    @IBAction func showHideImage() {
        imageView?.isHidden.toggle()
    }


    @IBAction func showHideBottomLabel() {
        bottomLabel?.isHidden.toggle()
    }
    
    @IBAction func showHideArrowLabel() {
        arrowLabel?.isHidden.toggle()
    }
    
    @IBAction func showHideToLabel() {
        toLabel?.isHidden.toggle()
    }
    
    @IBAction func updateFromLabel() {
        isFromBig.toggle()
        if isFromBig {
            fromLabel?.text = "From From From From From From From From From From From From From From From From"
        } else {
            fromLabel?.text = "From"
        }
    }
    
    @IBAction func updateToLabel() {
        isToBig.toggle()
        if isToBig {
            toLabel?.text = "To To To To To To To To To To To To To To To To To To To To To To To To To To To To To To To To To"
        } else {
            toLabel?.text = "To"
        }
    }
}
