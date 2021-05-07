//
//  Persistance.swift
//  Module14DataStorage
//
//  Created by Vladimir Mustafin on 07.05.2021.
//

import UIKit
import RealmSwift

class Data: Object{
    @objc dynamic var str: String = ""
}


class Persistance {
    static let shared = Persistance()
    
    private let realm = try! Realm()
    
    func getData() -> Data?{
        let data = realm.objects(Data.self).first ?? nil
        return data
    }
    
    func updateData(string: String){
//        if let Data = self.getData(){
//            try! realm.write{
//                realm.delete(Data)
//            }
//        }
        try! realm.write{
            let newData = Data()
            newData.str = string
            realm.add(newData)
        }
    }
}
