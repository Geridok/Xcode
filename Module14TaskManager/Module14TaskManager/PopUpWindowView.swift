//
//  PopUpWindowView.swift
//  Module14TaskManager
//
//  Created by Vladimir Mustafin on 29.05.2021.
//

import UIKit


protocol TaskActionDelegate {
    func saveData(taskName: String?,taskDecription: String?,date: Date?)
    func cancelData()
    func showDatePicker()
    func hideDatePicker()
}

class PopUpWindowView: UIView {

    //MARK: Properties
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        return button
    }()
    
    let addButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        return button
    }()
    
    let taskNameTextField: TextField = {
       let textField = TextField()
        textField.placeholder = "Enter task name"
        textField.font = UIFont(name: "System", size: 18.0)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let taskDescriptionTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Enter task description"
        textField.font = UIFont(name: "System", size: 10.0)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let datePickerLabelButton: UIButton = {
       let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: 14),
              .foregroundColor: UIColor.black,
              .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
           string: "Choose date",
           attributes: attributes
        )
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(callDatePicker), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        return button
    }()
    let datePickerImageButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "Calendar"), for: .normal)
        button.addTarget(self, action: #selector(callDatePicker), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var delegate: TaskActionDelegate?
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        self.addGestureRecognizer(tap)
        for item in [cancelButton,addButton,taskNameTextField,taskDescriptionTextField,datePickerLabelButton,datePickerImageButton] {
            self.addSubview(item)
        }
        
        //MARK: taskNameTextField constraints
        taskNameTextField.setContentHuggingPriority(UILayoutPriority(255), for: .vertical)
        NSLayoutConstraint.activate([
            taskNameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskNameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            taskNameTextField.heightAnchor.constraint(equalToConstant: 70),
            taskNameTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])
        //MARK: taskDescriptionTextField constraints
        taskDescriptionTextField.setContentCompressionResistancePriority(UILayoutPriority(0), for: .vertical)
        NSLayoutConstraint.activate([
            taskDescriptionTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskDescriptionTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            taskDescriptionTextField.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 5)
        ])
        //MARK: Add&CancelConstraints
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            cancelButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -5),
            cancelButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            
            addButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            addButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor)
        ])
        //MARK: datePickerButton constraints
        datePickerImageButton.setContentHuggingPriority(UILayoutPriority(255), for: .vertical)
        NSLayoutConstraint.activate([
            datePickerImageButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            datePickerImageButton.heightAnchor.constraint(equalToConstant: 30),
            datePickerImageButton.widthAnchor.constraint(equalToConstant: 30),
            datePickerImageButton.topAnchor.constraint(equalTo: taskDescriptionTextField.bottomAnchor, constant: 15),
            datePickerImageButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -10)
        ])
        //MARK: dateButton
        datePickerLabelButton.setContentHuggingPriority(UILayoutPriority(255), for: .vertical)
        NSLayoutConstraint.activate([
            datePickerLabelButton.leadingAnchor.constraint(equalTo: datePickerImageButton.trailingAnchor, constant: 15),
            datePickerLabelButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            datePickerLabelButton.heightAnchor.constraint(equalToConstant: 30),
            datePickerLabelButton.topAnchor.constraint(equalTo: taskDescriptionTextField.bottomAnchor, constant: 15),
            datePickerLabelButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    @objc func cancelAction(){
        delegate?.cancelData()
        delegate?.hideDatePicker()
    }
    
    @objc func addAction(){
        let date = Date()
        delegate?.saveData(taskName: taskNameTextField.text, taskDecription: taskDescriptionTextField.text, date: date)
    }
    
    @objc func callDatePicker(){
        delegate?.showDatePicker()
    }
    //MARK: Other func

}
