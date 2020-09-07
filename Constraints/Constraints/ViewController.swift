//
//  ViewController.swift
//  Constraints
//
//  Created by Vladimir Mustafin on 27.08.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureEnd))
            self.view.addGestureRecognizer(tapGesture)
        }
        
    @objc func tapGestureEnd(){
            view.endEditing(true)
        }

    @IBAction func changelabel(_ sender: UITextField) {
        if sender == leftTextField{
           leftLabel.text = leftTextField.text
        }else{
            rightLabel.text = rightTextField.text
        }
    }
    
    
}

