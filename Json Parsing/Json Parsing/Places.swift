//
//  countries.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 25.03.2021.
//

import Foundation
import SwiftyJSON

struct placeInfo {
    var name: String
    var lat: Double
    var lon: Double
}

class Singleton {

    static var placesInfo: Singleton = {
        let instance = Singleton()
        return instance
    }()
    
    private init() {
        if let file = Bundle.main.path(forResource: "city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: file))
                let json = try JSON(data: data)
                self.json = json
                for (_,subJson):(String, JSON) in json {
                    if let name = subJson["name"].string{
                        placesName.append(name)
                    }
                }
            } catch {
                json = JSON.null
            }
        } else {
            json = JSON.null
        }
    }
    private var placesName:[String] = []
    private var mostPopularCounries:[String] = ["Moscow","Novosibirsk","London","New York","Minsk","Kyiv","Tokyo","Washington","Saint Petersburg"]
    private var json: JSON = JSON.null

    func getPlacesNames() -> [String] {
        return placesName
    }
    func getMostPopularCountries() -> [String]{
        return mostPopularCounries
    }
    
    func getPlaceInfo(place: String) -> placeInfo{
        if let index = placesName.firstIndex(of: place){
            let info = placeInfo(name: place, lat: json[index]["coord"]["lat"].doubleValue, lon: json[index]["coord"]["lon"].doubleValue)
            return info
        }
        return placeInfo(name: "", lat: 1, lon: 1)
    }
}

extension Singleton: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
