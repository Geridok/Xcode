//
//  StubViewController.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 30.03.2021.
//

import UIKit
import SVProgressHUD
import RealmSwift

class StubViewController: UIViewController {

    var weatherLoaderAlamFire: WeatherLoader?
    
    var isHourlyWeatherLoaded = false
    var isDailyWheatherLoaded = false
    var isCurrentWeatherLoaded = false
    private let realm = try! Realm()
    
    
    let dataStorage = Persistance.shared
    
    var currentPlaceName:String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let data = dataStorage.getData(){
            if (currentPlaceName == nil){
                segue(data: data)
            }
            if(data.currentPlaceName != currentPlaceName){
                updateData()
            }else{
                segue(data: data)
            }
            
        }else{
            updateData()
        }
    }
    func segue(data: WeatherData? = nil){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = mainStoryBoard.instantiateViewController(identifier: "StandartWeatherViewController") as? WeatherViewController else{
            print("Can't load view controller")
            return
        }
        
        isHourlyWeatherLoaded = false
        isDailyWheatherLoaded = false
        isCurrentWeatherLoaded = false
        
        destinationViewController.modalTransitionStyle = .crossDissolve
        destinationViewController.modalPresentationStyle = .fullScreen
        destinationViewController.stubDelegate = self
        
        if let weatherData = data {
            destinationViewController.currentWeather = weatherData.currentWeather
            destinationViewController.hourlyWeather = weatherData.hourlyWeather
            destinationViewController.dayInfo = weatherData.dailyWeather
            currentPlaceName = weatherData.currentPlaceName
        }else{
            destinationViewController.currentWeather = weatherLoaderAlamFire!.currentWeather
            destinationViewController.hourlyWeather = weatherLoaderAlamFire!.hourlyWeather
            destinationViewController.dayInfo = weatherLoaderAlamFire!.dayInfo
            dataStorage.updateData(currentWeather: weatherLoaderAlamFire!.currentWeather, hourlyWeather: weatherLoaderAlamFire!.hourlyWeather, dailyWeather: weatherLoaderAlamFire!.dayInfo, currentCity: currentPlaceName ?? "Moscow")
        }
        destinationViewController.currentPlaceName = currentPlaceName
        SVProgressHUD.dismiss()
        present(destinationViewController, animated: true, completion: nil)
        
    }
    private func updateData(){
        SVProgressHUD.show()
        weatherLoaderAlamFire = WeatherLoader()
        weatherLoaderAlamFire?.delegat = self
        weatherLoaderAlamFire?.updateDataForPlace(place: currentPlaceName ?? "Moscow")
    }
}

extension StubViewController: WeatherLoaderDelegate{
    func loadedCurrentWeather() {
        isCurrentWeatherLoaded.toggle()
        if(isCurrentWeatherLoaded && isDailyWheatherLoaded && isHourlyWeatherLoaded){
            self.segue()
        }
    }
    
    func loadedDailyWheather() {
        isDailyWheatherLoaded.toggle()
        if(isCurrentWeatherLoaded && isDailyWheatherLoaded && isHourlyWeatherLoaded){
            self.segue()
        }
    }
    
    func loadedHourlyWeather() {
        isHourlyWeatherLoaded.toggle()
        if(isCurrentWeatherLoaded && isDailyWheatherLoaded && isHourlyWeatherLoaded){
            self.segue()
        }
    }
    

        
}


extension StubViewController: StubDelegate{
    
    
    func changePlaceName(place: String) {
        currentPlaceName = place
    }
    
    
}

extension Double {
    func string(maximumFractionDigits: Int = 2) -> String {
        let s = String(format: "%.\(maximumFractionDigits)f", self)
        for i in stride(from: 0, to: -maximumFractionDigits, by: -1) {
            if s[s.index(s.endIndex, offsetBy: i - 1)] != "0" {
                return String(s[..<s.index(s.endIndex, offsetBy: i)])
            }
        }
        return String(s[..<s.index(s.endIndex, offsetBy: -maximumFractionDigits - 1)])
    }
}
