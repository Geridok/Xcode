//
//  Main.swift
//  Transitions&Interactions
//
//  Created by Владимир Мустафин on 19.04.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit


class Main: UIViewController {
    
    
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    private var IntegratedVC: Integrated?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? Integrated, segue.identifier == "Integrated"{
            IntegratedVC = vc;
            IntegratedVC?.delegate = self
        }
    }
    @IBAction func changeIntegratedBackgroundColor(_ sender:UIButton){
        
        switch sender {
        case greenButton:
            IntegratedVC?.self.view.backgroundColor = UIColor.green
        case blueButton:
            IntegratedVC?.self.view.backgroundColor = UIColor.blue
        case redButton:
            IntegratedVC?.self.view.backgroundColor = UIColor.red
        default:
            return
        }
    }

}

extension Main: IntegratedDelegat{
    func changeBackGroundColor(_ backGroundColor: UIColor) {
        self.view.backgroundColor = backGroundColor
    }
    
    
}
