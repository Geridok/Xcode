//
//  CategoriesLoader.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 23.03.2021.
//

import Foundation
import Alamofire

protocol WeatherLoaderDelegate {
    func loadedCurrentWeather()
    func loadedDailyWheather()
    func loadedHourlyWeather()
}

class WeatherLoader{
    
    
    var delegat: WeatherLoaderDelegate?
    
    var currentWeather: CurrentWeather!
    
    var hourlyWeather: [HourlyWeather] = []
    
    var dayInfo: [DayInfo] = []
    
    
    func updateDataForPlace(place: String){
        
        let instanse = Singleton.placesInfo
        
        let placeInfo = instanse.getPlaceInfo(place: place)
        
        let curWeatherRequest = WeatherRequests.current + RequestParam.lat + String(placeInfo.lat) + RequestParam.lon + String(placeInfo.lon) + RequestParam.appid
        AF.request(curWeatherRequest).responseJSON{ response in
            if let obj = try? response.result.get(){
                if let jsonDict = obj as? NSDictionary{
                    let curWeather = CurrentWeather()
                    self.currentWeather = curWeather.ini(data: jsonDict)

                }
            }
            DispatchQueue.main.async {
                self.delegat?.loadedCurrentWeather()
            }
        }
        
        let hourlyWeatherRequest = WeatherRequests.onecall + RequestParam.lat + String(placeInfo.lat) + RequestParam.lon + String(placeInfo.lon) + RequestParam.hourly + RequestParam.appid
        
        AF.request(hourlyWeatherRequest).responseJSON{ response in
            if let obj = try? response.result.get(){
                if let jsonDict = obj as? NSDictionary{
                    let timeZoneOffset = jsonDict["timezone_offset"] as? Double
                    if let dailyArr = jsonDict["hourly"] as? NSArray {
                        for (data) in dailyArr where data is NSDictionary{
                            let horWeather = HourlyWeather()
                            if let readyHourlyInfo = horWeather.ini(data: data as! NSDictionary, timeZoneOffset: timeZoneOffset ?? 0){
                                self.hourlyWeather.append(readyHourlyInfo)
                            }

                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.delegat?.loadedHourlyWeather()
            }
        }
        
        
        let dailyWeatherRequest = WeatherRequests.onecall + RequestParam.lat + String(placeInfo.lat) + RequestParam.lon + String(placeInfo.lon) + RequestParam.daily7 + RequestParam.appid
        
        AF.request(dailyWeatherRequest).responseJSON{ response in
            if let obj = try? response.result.get(){
                if let jsonDict = obj as? NSDictionary{
                    let timeZoneOffset = jsonDict["timezone_offset"] as? Double
                    if let dailyArr = jsonDict["daily"] as? NSArray {
                        for (data) in dailyArr where data is NSDictionary{
                            let dayInfo = DayInfo()
                            if let readyDay = dayInfo.ini(data: data as! NSDictionary, timeZoneOffset: timeZoneOffset ?? 0){
                                self.dayInfo.append(readyDay)
                                }
                            }
                    }
                }

            }
            DispatchQueue.main.async {
                self.delegat?.loadedDailyWheather()
            }
        }
    }
}
