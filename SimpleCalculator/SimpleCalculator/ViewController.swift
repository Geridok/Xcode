//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by Владимир Мустафин on 29.03.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

enum Operation {
    case addition, subtraction, power, multiplication, division, equal
}


class ViewController: UIViewController {
    
    var result:Int64 = 0
    var errorInput = false
    var lastPressedOperation = Operation.equal
        
    @IBOutlet weak var calculationResult: UILabel!
    
    @IBOutlet weak var inputNumber: UITextField!
    
    private func refiilCalculationResult(){
        calculationResult.text = String(result)
        inputNumber.text = ""
    }
    
    private func checkInput() -> Int64?{
        if let myNumber = NumberFormatter().number(from: inputNumber.text!) {
          let myInt = Int64(myNumber.intValue)
          return myInt
        } else {
          errorInput = true
          calculationResult.text = "Incorrect input"
          return nil
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cleanResult(_ sender: Any) {
        result = 0
        calculationResult.text = String(result)
    }
    
    @IBAction func cleanErrorMessage(_ sender: Any) {
        if errorInput {
            errorInput = false
            calculationResult.text = String(result)
        }
    }
    
    @IBAction func addition(_ sender: Any) {
        if errorInput { return }
        guard let value = checkInput() else {
            return
        }
        result += value
        lastPressedOperation = .addition
        refiilCalculationResult()
    }
    
    
    @IBAction func subtraction(_ sender: Any) {
        if errorInput { return }
        guard let value = checkInput() else {
            return
        }
        lastPressedOperation = .subtraction
        result -= value
        refiilCalculationResult()
    }
    
    
    @IBAction func power(_ sender: Any) {
       if errorInput { return }
        guard let value = checkInput() else {
            return
        }
        if(value >= 63 ){   //тут в общем-то кастыль, ибо если значение больше этого, оно падает с тем что не может преобразовать, хотя double вроде хранит в себе 1,79*10^308, а 2^63 гораздо менше, в общем не понял почему.
            errorInput = true
            calculationResult.text = "Incorrect input"
        }else {
            result = Int64(pow(2, Double(value)))
            lastPressedOperation = .power
            refiilCalculationResult()
        }
    }
    
    @IBAction func multiplication(_ sender: Any) {
        if errorInput { return }
        guard let value = checkInput() else {
            return
        }
        if(result == 0){
            result = value
        }else{
            result *= value
        }
        lastPressedOperation = .multiplication
        refiilCalculationResult()
    }
    
    
    @IBAction func division(_ sender: Any) {
        if errorInput { return }
        guard let value = checkInput() else {
            return
        }
        if(result == 0){
            result = value
        }else{
            result /= value
            
            if(result%value >= 5){
                result += 1
            }
        }
        lastPressedOperation = .division
        refiilCalculationResult()
    }
    
    
    @IBAction func equal(_ sender: Any) {
        if errorInput { return }
        
        switch lastPressedOperation {
        case .addition:
            addition(0)
        case .subtraction:
            subtraction(0)
        case .power:
            power(0)
        case .multiplication:
            multiplication(0)
        case .division:
            division(0)
        case .equal:
            return
        }
        lastPressedOperation = .equal
    }
}

