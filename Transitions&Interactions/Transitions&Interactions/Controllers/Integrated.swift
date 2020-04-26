//
//  Integrated.swift
//  Transitions&Interactions
//
//  Created by Владимир Мустафин on 19.04.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

protocol IntegratedDelegat: AnyObject {
    func changeBackGroundColor(_ backGroundColor:UIColor)
}

class Integrated: UIViewController {

    var delegate:IntegratedDelegat?
    
    deinit {
        delegate = nil
    }
    
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redButton.tag = 0
        greenButton.tag = 1
        blueButton.tag = 2
    }
    
    @IBAction func changeBackGroundColorMain(_ sender:UIButton){
        let color = CollorPallete(rawValue: sender.tag)
        delegate?.changeBackGroundColor(color?.rgb ?? UIColor.yellow)
    }
    
}

