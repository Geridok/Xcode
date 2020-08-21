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
    
    let greenView = UIView(frame: CGRect(x: 87, y: 300, width: 250, height: 250))
    let blueView = UIView(frame: CGRect(x: 87, y: 300, width: 250, height: 250))
    let purpleView = UIView(frame: CGRect(x: 87, y: 300, width: 250, height: 250))
    
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
        whichToShow(selectedIndex: sender.selectedSegmentIndex)
    }
   
    private func whichToShow(selectedIndex: Int){
        for (index, view) in [blueView, purpleView, greenView].enumerated() {
            view.isHidden = index != selectedIndex
        }
    }

}
