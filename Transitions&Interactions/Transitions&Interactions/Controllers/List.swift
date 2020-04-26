//
//  ListSecond.swift
//  Transitions&Interactions
//
//  Created by Владимир Мустафин on 19.04.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import Foundation
import UIKit

protocol ListDelegate: AnyObject {
    func sendChoice(_ choice:String)
    func changeBackGroundColor(_ backGroundColor:UIColor)
}

class List: UIViewController {
    
    var textLabel:String = "Geen is selected"
    var delegate:ListDelegate?
    deinit {
        delegate = nil
    }
    
    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        choiceLabel.text = textLabel
        redButton.tag = 0
        greenButton.tag = 1
        blueButton.tag = 2
    }
    
    @IBAction func chooseColor(_ sender:UIButton){
        navigationController?.popViewController(animated: true)
        let color = CollorPallete(rawValue: sender.tag)
        delegate?.changeBackGroundColor(color?.rgb ?? UIColor.yellow)
        delegate?.sendChoice(color?.selectedDescription ?? "")
    }

    
}
