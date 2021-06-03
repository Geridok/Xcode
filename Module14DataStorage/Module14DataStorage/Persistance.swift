//
//  Persistance.swift
//  Module14dataStorage
//
//  Created by Vladimir Mustafin on 22.05.2021.
//

import Foundation

class Persistance{
    static let shared = Persistance()
    
    private let kUserNameKey = "Persistance.kUserNameKey"
    var name:String? {
        set { UserDefaults.standard.set(newValue,forKey: kUserNameKey)}
        get { return UserDefaults.standard.string(forKey: kUserNameKey)}
    }
    
    private let kUserSurnameKey = "Persistance.kUserSurnameKey"
    var surname: String? {
        set { UserDefaults.standard.set(newValue,forKey: kUserSurnameKey)}
        get { return UserDefaults.standard.string(forKey: kUserSurnameKey)}
    }
}
