//
//  BigLabelViewController.swift
//  Constraints
//
//  Created by Vladimir Mustafin on 07.09.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class BigLabelViewController: UIViewController {

    @IBOutlet weak var TextUILabel: UILabel!
    @IBOutlet weak var SwitchUIButton: UIButton!
    
    var isBig = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func changeLineAmount() {
        if !isBig {
            TextUILabel.numberOfLines = 5
            isBig = true
            return
        }
        TextUILabel.numberOfLines = 1
        isBig = false
    }
}
