//
//  SegmentViewController.swift
//  Standart UI
//
//  Created by Vladimir Mustafin on 19.08.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController {

    @IBOutlet weak var viewSegmentControl: UISegmentedControl!
    
    var greenView = UIView(frame: CGRect(x: 87, y: 300, width: 250, height: 250))
    var blueView = UIView(frame: CGRect(x: 87, y: 300, width: 250, height: 250))
    var purpleView = UIView(frame: CGRect(x: 87, y: 300, width: 250, height: 250))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greenView.backgroundColor = .green
        blueView.backgroundColor = .blue
        purpleView.backgroundColor = .purple
        self.view.addSubview(purpleView)
        purpleView.isHidden = true
        self.view.addSubview(blueView)
        blueView.isHidden = true
        self.view.addSubview(greenView)
    }
    
    @IBAction func ViewChanged(_ sender: UISegmentedControl) {
        guard sender == viewSegmentControl else {
            return
        }
        whichToShow(index: sender.selectedSegmentIndex)
    }
   
    private func whichToShow(index: Int){
        switch index {
        case 0:
            blueView.isHidden = true
            purpleView.isHidden = true
            greenView.isHidden = false
        case 1:
            blueView.isHidden = false
            purpleView.isHidden = true
            greenView.isHidden = true
         case 2:
            blueView.isHidden = true
            purpleView.isHidden = false
            greenView.isHidden = true
        default:
            return
        }
    }

}
