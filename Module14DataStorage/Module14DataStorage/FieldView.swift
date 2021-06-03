//
//  FieldView.swift
//  Module14dataStorage
//
//  Created by Vladimir Mustafin on 21.05.2021.
//

import Foundation
import UIKit

protocol DataSourceDelegate: AnyObject{
    func nameChange(newName: String?)
    func surnameChange(newSurname: String?)
}

class FieldView: UIView{
    
    @IBOutlet weak var surNameTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    weak var delegate: DataSourceDelegate?
    
    static func loadFromXib() -> FieldView {
        let xib = UINib(nibName: "FieldView", bundle: nil)
        
        return xib.instantiate(withOwner: self, options: nil).first as! FieldView
    }
    
    
    func configure(name: String?,surname: String?){
        
        let cornerRadius: CGFloat = 15
        
        for field in [nameTextField,surNameTextField]{
            field?.layer.cornerRadius = cornerRadius
            field?.clipsToBounds = true
        }
        
        if name != nil{
            nameTextField.text = name!
        }
        if surname != nil{
            surNameTextField.text = surname!
        }
        
    }
    
    @IBAction func setName(_ sender: UITextField) {
        delegate?.nameChange(newName: sender.text)
    }
    
    @IBAction func setSurname(_ sender: UITextField) {
        delegate?.surnameChange(newSurname: sender.text)
    }
    
}
