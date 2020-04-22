//
//  ListSecond.swift
//  Transitions&Interactions
//
//  Created by Владимир Мустафин on 19.04.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import Foundation
import UIKit

protocol ListDelegate {
    func sendChoice(_ choice:String)
    func changeBackGroundColor(_ backGroundColor:UIColor)
}

class List: UIViewController {
    
    var textLabel:String = "Geen is selected"
    var delegate:ListDelegate?
    
    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var red: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        choiceLabel.text = textLabel
    }
    
    @IBAction func chooseColor(_ sender:UIButton){
        navigationController?.popViewController(animated: true)
        switch sender {
        case green:
            delegate?.sendChoice("Green is selected")
            delegate?.changeBackGroundColor(UIColor.green)
            
        case blue:
            delegate?.sendChoice("Blue is selected")
            delegate?.changeBackGroundColor(UIColor.blue)
        case red:
            delegate?.sendChoice("Red is selected")
            delegate?.changeBackGroundColor(UIColor.red)
        default:
            return
        }
    }

    
}
