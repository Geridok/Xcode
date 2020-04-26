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
    
    deinit {
        IntegratedVC = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redButton.tag = 0
        greenButton.tag = 1
        blueButton.tag = 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? Integrated, segue.identifier == "Integrated"{
            IntegratedVC = vc;
            IntegratedVC?.delegate = self
        }
    }
    @IBAction func changeIntegratedBackgroundColor(_ sender:UIButton){
        let color = CollorPallete(rawValue: sender.tag)
        IntegratedVC?.self.view.backgroundColor = color?.rgb
    }

}

extension Main: IntegratedDelegat{
    func changeBackGroundColor(_ backGroundColor: UIColor) {
        self.view.backgroundColor = backGroundColor
    }
    
    
}
