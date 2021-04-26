//
//  WheatherLoaderStandart.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 30.03.2021.
//

import Foundation

class WeatherLoaderStandart{

    var delegat: WeatherLoaderDelegate?

    var currentWeather: CurrentWeather!

    var hourlyWeather: [HourlyWeather] = []

    var dayInfo: [DayInfo] = []
    
    func updateDataForPlace(place: String){

        let instanse = Singleton.placesInfo

        let placeInfo = instanse.getPlaceInfo(place: place)

        let curWeatherRequest = WeatherRequests.current + RequestParam.lat + String(placeInfo.lat) + RequestParam.lon + String(placeInfo.lon) + RequestParam.appid

        let urlCurrent = URL(string: curWeatherRequest)!
        let requestCurrent = URLRequest(url: urlCurrent)
        let taskCurrent = URLSession.shared.dataTask(with: requestCurrent) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary{
                self.currentWeather = CurrentWeather(data: jsonDict)
            }
            DispatchQueue.main.async {
                self.delegat?.loadedCurrentWeather()
            }
        }
        taskCurrent.resume()

        let hourlyWeatherRequest = WeatherRequests.onecall + RequestParam.lat + String(placeInfo.lat) + RequestParam.lon + String(placeInfo.lon) + RequestParam.hourly + RequestParam.appid

        let urlHourly = URL(string: hourlyWeatherRequest)!
        let requestHourly = URLRequest(url: urlHourly)
        let taskHourly = URLSession.shared.dataTask(with: requestHourly) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary{
                
                let timeZoneOffset = jsonDict["timezone_offset"] as? Double
                if let dailyArr = jsonDict["hourly"] as? NSArray {
                    for (data) in dailyArr where data is NSDictionary{
                        if let readyHourlyInfo = HourlyWeather(data: data as! NSDictionary, timeZoneOffset: timeZoneOffset ?? 0){
                            self.hourlyWeather.append(readyHourlyInfo)
                        }
                    }
                }

            }
            DispatchQueue.main.async {
                self.delegat?.loadedHourlyWeather()
            }
        }
        taskHourly.resume()

        let dailyWeatherRequest = WeatherRequests.onecall + RequestParam.lat + String(placeInfo.lat) + RequestParam.lon + String(placeInfo.lon) + RequestParam.daily7 + RequestParam.appid

        let urlDaily = URL(string: dailyWeatherRequest)!
        let requestDaily = URLRequest(url: urlDaily)
        let taskDaily = URLSession.shared.dataTask(with: requestDaily) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary{
                let timeZoneOffset = jsonDict["timezone_offset"] as? Double
                if let dailyArr = jsonDict["daily"] as? NSArray {
                    for (data) in dailyArr where data is NSDictionary{
                        if let readyDay = DayInfo(data: data as! NSDictionary, timeZoneOffset: timeZoneOffset ?? 0){
                            self.dayInfo.append(readyDay)
                            }
                        }
                }

            }
            DispatchQueue.main.async {
                self.delegat?.loadedDailyWheather()
            }
        }
        taskDaily.resume()

    }

}
