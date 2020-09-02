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
    
    @IBOutlet weak var firstGreenButton: UIButton!
    @IBOutlet weak var firstBlueButton: UIButton!
    @IBOutlet weak var firstYellowButton: UIButton!
    
    @IBOutlet weak var horizontalStackView: UIStackView!
    
    @IBOutlet weak var vеrticalStackView: UIStackView!
    
    @IBOutlet weak var thirdGreenButton: UIButton!
    @IBOutlet weak var thirdBlueButton: UIButton!
    @IBOutlet weak var thirdYellowButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButtons()
    }
    
    @IBAction func changeButtons() {
        let index = buttonsSegmentController.selectedSegmentIndex
        switch index {
        case 0:
            for button in [firstBlueButton,firstGreenButton,firstYellowButton] {
                button?.isHidden = false
            }
            for button in [thirdBlueButton,thirdGreenButton,thirdYellowButton] {
                button?.isHidden = true
            }
            horizontalStackView.isHidden = true
            vеrticalStackView.isHidden = true
        case 1:
            for button in [firstBlueButton,firstGreenButton,firstYellowButton] {
                button?.isHidden = true
            }
            for button in [thirdBlueButton,thirdGreenButton,thirdYellowButton] {
                button?.isHidden = true
            }
            horizontalStackView.isHidden = false
            vеrticalStackView.isHidden = true
        case 2:
            for button in [firstBlueButton,firstGreenButton,firstYellowButton] {
                button?.isHidden = true
            }
            for button in [thirdBlueButton,thirdGreenButton,thirdYellowButton] {
                button?.isHidden = false
            }
            horizontalStackView.isHidden = true
            vеrticalStackView.isHidden = true
        case 3:
            for button in [firstBlueButton,firstGreenButton,firstYellowButton] {
                button?.isHidden = true
            }
            for button in [thirdBlueButton,thirdGreenButton,thirdYellowButton] {
                button?.isHidden = true
            }
            horizontalStackView.isHidden = true
            vеrticalStackView.isHidden = false
        default:
            return
        }
    }
    

}
