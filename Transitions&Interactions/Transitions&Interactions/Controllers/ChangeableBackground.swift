//
//  ChangeableBackgroundSecond.swift
//  Transitions&Interactions
//
//  Created by Владимир Мустафин on 19.04.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import Foundation
import UIKit

class ChangeableBackgroundSecond: UIViewController {
    
    @IBOutlet weak var choceLabel: UILabel!

        override func viewDidLoad() {
        super.viewDidLoad()
            choceLabel.text = "Green is selected"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? List, segue.identifier == "ShowList"{
            vc.textLabel = choceLabel.text!
            vc.delegate = self
        }
    }
}

extension ChangeableBackgroundSecond: ListDelegate{
    func changeBackGroundColor(_ backGroundColor: UIColor) {
        self.view.backgroundColor = backGroundColor
    }
    
    func sendChoice(_ choice: String) {
        choceLabel.text = choice
    }
    
    
    
}
