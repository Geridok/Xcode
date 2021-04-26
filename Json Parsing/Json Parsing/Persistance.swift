//
//  Persistance.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 19.04.2021.
//

import Foundation
import RealmSwift

class WeatherData: Object{
    @objc dynamic var currentWeather: CurrentWeather?
    @objc dynamic var hourlyWeather: [HourlyWeather]?
    @objc dynamic var dailyWeather: [DayInfo]?
    @objc dynamic var currentCity: String?
    @objc dynamic var date:String = {
        let data = Date()
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "ddMMM HH:mm"
        dayTimePeriodFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let dateString = dayTimePeriodFormatter.string(from: data)
        
        return dateString
        
    }()
    let imagesArrCurrent = List<String>()
    let imagesArrHourly = List<String>()
    let imagesArrDaily = List<String>()
}

func saveImage(image: UIImage,imageName: String) -> Bool {
    guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
        return false
    }
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return false
    }
    do {
        try data.write(to: directory.appendingPathComponent(imageName)!)
        return true
    } catch {
        print(error.localizedDescription)
        return false
    }
}
func getSavedImage(named: String) -> UIImage? {
    if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
        return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
    }
    return nil
}

class Persistance {
    static let shared = Persistance()
    
    private let realm = try! Realm()
    
    func getData() -> WeatherData?{
        let weatherData = realm.objects(WeatherData.self).first ?? nil
        return weatherData
    }
    
    func updateData(currentWeather: CurrentWeather,hourlyWeather: [HourlyWeather],dailyWeather: [DayInfo],currentCity: String){
        if let weatherData = self.getData(){
            try! realm.write{
                realm.delete(weatherData)
            }
            try! realm.write{
                let newWeatherData = WeatherData()
                newWeatherData.currentWeather = currentWeather
                newWeatherData.hourlyWeather = hourlyWeather
                newWeatherData.dailyWeather = dailyWeather
                newWeatherData.currentCity = currentCity
                realm.add(newWeatherData)
            }
        }
    }
}
