//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by Владимир Мустафин on 29.03.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

enum Operation {
    case addition, subtraction, power, multiplication, division, equal, comma, percent, none
}


class ViewController: UIViewController {
    
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var commaButton: UIButton!
    @IBOutlet weak var plusMinusButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var substractButton: UIButton!
    @IBOutlet weak var powerButton: UIButton!
    
    let formatter = NumberFormatter()
    var result:Double = 0
    var previousresult:Double = 0
    var percent:UInt = 0
    var digitCapacityFraction:UInt = 1
    var digitPressed = false
    var lastPressedOperation = Operation.none
    // TODO : сделать счетчик цифр
    @IBOutlet weak var calculationResult: UILabel!
    @IBOutlet weak var information: UILabel!
    
    private func updateCalculationResult(){
        formatter.maximumFractionDigits = 10
        formatter.maximumIntegerDigits = 10
        formatter.minimumFractionDigits = Int(digitCapacityFraction - 1)
        calculationResult.text = formatter.string(from: NSNumber(value: result))
    }
    
    private func cleanResult() {
        result = 0
        digitCapacityFraction = 1
        formatter.minimumFractionDigits = Int(digitCapacityFraction - 1)
        calculationResult.text = formatter.string(from: NSNumber(value: result))
    }
    
    private func addEntirePart(_ value:UInt){
        result = result*10 + Double(value)
    }
    
    private func addFractionalPart(_ value:UInt){
        result += Double(Double(value)/pow(10,Double(digitCapacityFraction)))
        digitCapacityFraction += 1
    }
    @IBAction func cleanAll() {
        result = 0
        digitCapacityFraction = 1
        digitPressed = false
        lastPressedOperation = .none
        formatter.minimumFractionDigits = Int(digitCapacityFraction - 1)
        calculationResult.text = formatter.string(from: NSNumber(value: result))
    }
    
    @IBAction func addDigit(_ sender: UIButton){
        if( !digitPressed && lastPressedOperation != .comma){
            cleanResult()
        }
        switch sender {
        case oneButton:
            if(lastPressedOperation != .comma){
                addEntirePart(1)
            }else{
                addFractionalPart(1)
            }
            digitPressed = true
        case twoButton:
            if(lastPressedOperation != .comma){
                addEntirePart(2)
            }else{
                addFractionalPart(2)
            }
            digitPressed = true
        case threeButton:
            if(lastPressedOperation != .comma){
                addEntirePart(3)
            }else{
                addFractionalPart(3)
            }
            digitPressed = true
        case fourButton:
            if(lastPressedOperation != .comma){
                addEntirePart(4)
            }else{
                addFractionalPart(4)
            }
            digitPressed = true
        case fiveButton:
            if(lastPressedOperation != .comma){
                addEntirePart(5)
            }else{
                addFractionalPart(5)
            }
            digitPressed = true
        case sixButton:
            if(lastPressedOperation != .comma){
                addEntirePart(6)
            }else{
                addFractionalPart(6)
            }
            digitPressed = true
        case sevenButton:
            if(lastPressedOperation != .comma){
                addEntirePart(7)
            }else{
                addFractionalPart(7)
            }
            digitPressed = true
        case eightButton:
            if(lastPressedOperation != .comma){
                addEntirePart(8)
            }else{
                addFractionalPart(8)
            }
            digitPressed = true
        case nineButton:
            if(lastPressedOperation != .comma){
                addEntirePart(9)
            }else{
                addFractionalPart(9)
            }
            digitPressed = true
        case zeroButton:
            if(lastPressedOperation != .comma){
                addEntirePart(0)
            }else{
                addFractionalPart(0)
            }
            digitPressed = true
        case commaButton:
            if(lastPressedOperation != .comma){
                lastPressedOperation = .comma
            }
        default:
            return
        }
        updateCalculationResult()
    }
    
    @IBAction func changeSign() {
        result = -result
        updateCalculationResult()
    }
    
    @IBAction func binaryOperations(_ sender:UIButton){
        digitPressed = false
        if(lastPressedOperation != .equal){
            equal()
        }
        switch sender {
        case divisionButton:
            if(previousresult != 0){
                result = previousresult/result
                previousresult = result
            }else{
                previousresult = result
            }
            lastPressedOperation = .division
            updateCalculationResult()
        case multiplyButton:
            if(previousresult != 0){
                result = previousresult*result
                previousresult = result
            }else{
                previousresult = result
            }
            lastPressedOperation = .multiplication
            updateCalculationResult()
        case addButton:
            if(previousresult != 0){
                result = previousresult+result
                previousresult = result
            }else{
                previousresult = result
            }
            lastPressedOperation = .addition
            updateCalculationResult()
        case substractButton:
            if(previousresult != 0){
                result = previousresult-result
                previousresult = result
            }else{
                previousresult = result
            }
            lastPressedOperation = .subtraction
            updateCalculationResult()
        case percentButton:
            if(previousresult != 0){
                result = (previousresult * result)/100
                previousresult = result
            }else{
                previousresult = result
            }
            lastPressedOperation = .percent
            updateCalculationResult()
        default:
            return
        }
    }
    
    @IBAction func power(){
        digitPressed = false
        result = pow(2, result)
        updateCalculationResult()
        lastPressedOperation = .power
    }
    @IBAction func equal() {
        if(previousresult == 0){
            return
        }
        switch lastPressedOperation {
        case .addition:
            lastPressedOperation = .equal
            binaryOperations(addButton)
        case .subtraction:
            lastPressedOperation = .equal
            binaryOperations(substractButton)
        case .power:
            lastPressedOperation = .equal
            binaryOperations(powerButton)
        case .multiplication:
            lastPressedOperation = .equal
            binaryOperations(multiplyButton)
        case .division:
            lastPressedOperation = .equal
            binaryOperations(divisionButton)
        case .percent:
            lastPressedOperation = .equal
            binaryOperations(percentButton)
        case .equal:
            return
        default:
            return
        }
        previousresult = 0
        //updateCalculationResult()
        digitPressed = false
    }
//
//    @IBAction func addition(_ sender: Any) {
//        if errorInput { return }
//
//        result += value
//        lastPressedOperation = .addition
//    }
//
//
//    @IBAction func subtraction(_ sender: Any) {
//        if errorInput { return }
//        guard let value = checkInput() else {
//            return
//        }
//        lastPressedOperation = .subtraction
//        result -= value
//        refiilCalculationResult()
//    }
//
//
//    @IBAction func power(_ sender: Any) {
//       if errorInput { return }
//        guard let value = checkInput() else {
//            return
//        }
//        if(value >= 63 ){   //тут в общем-то кастыль, ибо если значение больше этого, оно падает с тем что не может преобразовать, хотя double вроде хранит в себе 1,79*10^308, а 2^63 гораздо менше, в общем не понял почему.
//            errorInput = true
//            calculationResult.text = "Incorrect input"
//        }else {
//            result = Int64(pow(2, Double(value)))
//            lastPressedOperation = .power
//            refiilCalculationResult()
//        }
//    }
//
//    @IBAction func multiplication(_ sender: Any) {
//        if errorInput { return }
//        guard let value = checkInput() else {
//            return
//        }
//        if(result == 0){
//            result = value
//        }else{
//            result *= value
//        }
//        lastPressedOperation = .multiplication
//        refiilCalculationResult()
//    }
//
//
//    @IBAction func division(_ sender: Any) {
//        if errorInput { return }
//        guard let value = checkInput() else {
//            return
//        }
//        if(result == 0){
//            result = value
//        }else{
//            result /= value
//
//            if(result%value >= 5){
//                result += 1
//            }
//        }
//        lastPressedOperation = .division
//        refiilCalculationResult()
//    }
//
//

}

