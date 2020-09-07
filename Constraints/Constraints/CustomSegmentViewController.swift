//
//  CustomTabBarViewController.swift
//  Constraints
//
//  Created by Vladimir Mustafin on 02.09.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class CustomSegmentViewController: UIViewController {
    
    @IBOutlet weak var buttonsSegmentController: UISegmentedControl!
    
    @IBOutlet var firstButtonsArr: [UIButton]!
    
    @IBOutlet var thirdButtonsArr: [UIButton]!
    
    
    @IBOutlet weak var horizontalStackView: UIStackView!
    
    @IBOutlet weak var vеrticalStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButtons()
    }
    
    @IBAction func changeButtons() {
        let index = buttonsSegmentController.selectedSegmentIndex
        switch index {
        case 0:
            for button in firstButtonsArr {
                button.isHidden = false
            }
            for button in thirdButtonsArr {
                button.isHidden = true
            }
            horizontalStackView.isHidden = true
            vеrticalStackView.isHidden = true
        case 1:
            for button in firstButtonsArr {
                button.isHidden = true
            }
            for button in thirdButtonsArr {
                button.isHidden = true
            }
            horizontalStackView.isHidden = false
            vеrticalStackView.isHidden = true
        case 2:
            for button in firstButtonsArr {
                button.isHidden = true
            }
            for button in thirdButtonsArr {
                button.isHidden = false
            }
            horizontalStackView.isHidden = true
            vеrticalStackView.isHidden = true
        case 3:
            for button in firstButtonsArr {
                button.isHidden = true
            }
            for button in thirdButtonsArr {
                button.isHidden = true
            }
            horizontalStackView.isHidden = true
            vеrticalStackView.isHidden = false
        default:
            return
        }
    }
    

}
