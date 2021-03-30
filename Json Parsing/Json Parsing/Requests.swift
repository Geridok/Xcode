//
//  WhetherRequests.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 25.03.2021.
//

import Foundation

let appId:String = "497225f209534c65a530145241be12cc"

struct RequestParam{
    static let placeName = "q="
    static let dt = "&dt="
    static let appid = "&appid=" + appId
    static let metric = "&units="
    static let iconEnd = "@2x.png"
    static let lat = "lat="
    static let lon = "&lon="
    
    // here some strange bug on server, if u request server for daily weather, it will send u hourly and vice versa
    static let daily7 = "&exclude=hourly"
    static let hourly = "&exclude=daily"
}

struct WeatherRequests {
    //current Whether
    static let current = "https://api.openweathermap.org/data/2.5/weather?"
    //3 hour future and 5 day forward
    static let hour_5day = "https://api.openweathermap.org/data/2.5/forecast?"
    //daily 7 days & hourly
    static let onecall = "https://api.openweathermap.org/data/2.5/onecall?"
    //icon
    static let icon = "https://openweathermap.org/img/wn/"
}
