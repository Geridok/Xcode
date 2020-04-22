//
//  Integrated.swift
//  Transitions&Interactions
//
//  Created by Владимир Мустафин on 19.04.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

protocol IntegratedDelegat {
    func changeBackGroundColor(_ backGroundColor:UIColor)
}

class Integrated: UIViewController {

    var delegate:IntegratedDelegat?
    
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeBackGroundColorMain(_ sender:UIButton){
        switch sender {
        case greenButton:
            delegate?.changeBackGroundColor(UIColor.green)
        case blueButton:
            delegate?.changeBackGroundColor(UIColor.blue)
        case redButton:
            delegate?.changeBackGroundColor(UIColor.red)
        default:
            return
        }
    }
    
}
