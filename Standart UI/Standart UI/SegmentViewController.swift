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
    @IBOutlet weak var dateUIView: UIView!
    @IBOutlet weak var imageUIView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeZoneTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var signButton: UIButton!
    
    
    let formatter = DateFormatter()
    var positiveTimeZone = true
    var invalidTimeZone = false
    var timeZoneString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUIView.isHidden = true
        dateUIView.isHidden = false
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        updateDate()
        timeZoneTextField.text = signButton.titleLabel?.text
    }
    
    @IBAction func ViewChanged(_ sender: UISegmentedControl) {
        guard sender == viewSegmentControl else {
            return
        }
        whichToShow(selectedIndex: sender.selectedSegmentIndex)
    }
   
    private func whichToShow(selectedIndex: Int){
        for (index, view) in [dateUIView,imageUIView].enumerated() {
            view?.isHidden = index != selectedIndex
        }
    }
    
    @IBAction func updateTimeZoneTextField() {
        formatter.timeZone = .current
        dateLabel.text = formatter.string(from: datePicker.date)
        if timeZoneString == "+" || timeZoneString == "-" {
            return
        }
            timeZoneString = "+"
            positiveTimeZone = true
            timeZoneTextField.text = timeZoneString
    }
    
    @IBAction func timeZoneChanged() {
        timeZoneString = timeZoneTextField.text ?? " "
        if(timeZoneString.count == 0 || timeZoneString.count == 1){
            updateTimeZoneTextField()
        }
        if let timeZoneHour = Int(timeZoneString){
            if(timeZoneHour > 14 || timeZoneHour < -12){
                timeZoneTextField.text = "Invalid Time Zone"
                view.endEditing(true)
            }else{
                let timeZoneSecond = timeZoneHour * 3600
                formatter.timeZone = TimeZone(secondsFromGMT: timeZoneSecond)
                updateDate()
            }
        }
    }
    
    @IBAction func changeSign() {
        if(positiveTimeZone){
            timeZoneString.remove(at: timeZoneString.startIndex)
            timeZoneString.insert("-", at: timeZoneString.startIndex)
            timeZoneTextField.text = timeZoneString
            positiveTimeZone = false
        }else{
            timeZoneString.remove(at: timeZoneString.startIndex)
            timeZoneString.insert("+", at: timeZoneString.startIndex)
            timeZoneTextField.text = timeZoneString
            positiveTimeZone = true
        }
    }
    
    @IBAction func updateDate() {
        dateLabel.text = formatter.string(from: datePicker.date)
    }
    
    //Image
    @IBOutlet weak var imageUIImageView: UIImageView!
    @IBOutlet weak var alpfaUISwith: UISwitch!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBAction func changeAlpha() {
        if alpfaUISwith.isOn {
            imageUIImageView.alpha = 0.3
            indicator.startAnimating()
        }else{
            imageUIImageView.alpha = 1.0
            indicator.stopAnimating()
        }
    }
}
