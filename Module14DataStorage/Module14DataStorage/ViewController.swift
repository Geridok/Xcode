//
//  ViewController.swift
//  Module14dataStorage
//
//  Created by Vladimir Mustafin on 19.05.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    var persistanceContainer: Persistance = {
        return Persistance.shared
    }()
    
    private var personInfoView:FieldView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        
        let personView = FieldView.loadFromXib()
        personView.backgroundColor = .gray
        view.addSubview(personView)
        personView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            personView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            personView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            personView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //personView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        personView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        personView.delegate = self
        personView.layer.cornerRadius = 20
        
        let gradient = CAGradientLayer()
        
        personView.layoutIfNeeded()
        
        gradient.frame = personView.bounds
        gradient.colors = [UIColor(red: 0.46, green: 0.89, blue: 0.76, alpha: 1.00).cgColor,UIColor(red: 0.30, green: 0.81, blue: 1.00, alpha: 1.00).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        personView.layer.insertSublayer(gradient, at: 0)
        
        personView.layer.cornerRadius = 20
        personView.clipsToBounds = true
        
        personInfoView = personView
        
        
        personInfoView?.configure(name: persistanceContainer.name, surname: persistanceContainer.surname)
        
    }

}


extension ViewController: DataSourceDelegate{
    
    func nameChange(newName: String?) {
        if(newName != nil ){
            persistanceContainer.name = newName
        }
    }
    
    func surnameChange(newSurname: String?) {
        if(newSurname != nil ){
            persistanceContainer.surname = newSurname
        }
    }
    
}
