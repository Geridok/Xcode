//
//  DatePickerPresenter.swift
//  Module14TaskManager
//
//  Created by Vladimir Mustafin on 01.06.2021.
//

import UIKit

protocol DatePickerValueChangedDelegate {
    func datePickerValueChanged(date: Date)
}

class PickerViewPresenter: UITextField {
    private lazy var doneToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.backgroundColor = .darkGray
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        let items = [flexSpace, doneButton]
        toolbar.items = items
        toolbar.sizeToFit()
        
        return toolbar
    }()

    private lazy var pickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(wheelChangedvalue), for: .valueChanged)
        return datePicker
    }()
    private var currentDate: Date = Date()
    
    var datePickerDelegate:DatePickerValueChangedDelegate?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        inputView = pickerView
        inputAccessoryView = doneToolbar
    }

    @objc func doneButtonTapped() {
        resignFirstResponder()
        datePickerDelegate?.datePickerValueChanged(date: pickerView.date)
    }

    func showPicker() {
        becomeFirstResponder()
    }
    
    @objc private func wheelChangedvalue(){
        datePickerDelegate?.datePickerValueChanged(date: pickerView.date)
    }
}
