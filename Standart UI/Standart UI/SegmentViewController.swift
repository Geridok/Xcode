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
    
    var ViewArray = [UIView(),UIView(),UIView()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewArray[0].backgroundColor = .green
        ViewArray[1].backgroundColor = .blue
        ViewArray[2].backgroundColor = .purple
        for item in ViewArray {
            item.frame = CGRect(x: 87, y: 300, width: 250, height: 250)
        }
        self.view.addSubview(ViewArray[0])
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ViewChanged(_ sender: UISegmentedControl) {
        guard sender == viewSegmentControl else {
            return
        }
        let segmentIndex = sender.selectedSegmentIndex
        self.view.addSubview(ViewArray[segmentIndex])
    }
    

}
