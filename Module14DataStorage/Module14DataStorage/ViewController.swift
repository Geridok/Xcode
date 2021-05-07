//
//  ViewController.swift
//  Module14DataStorage
//
//  Created by Vladimir Mustafin on 19.04.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataStorage = Persistance.shared
        
        dataStorage.updateData(string: "testString")
        
        let data = dataStorage.getData()
        
        let str = data?.str
        
    }


}

